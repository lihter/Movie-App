import Foundation

class MovieRepository: MovieRepositoryProtocol {

    static let shared: MovieRepositoryProtocol = MovieRepository()
    
    private let networkDataSource: MovieNetworkDataSourceProtocol!
    private let userDefaultsDataSource: UserDefaultsDataSourceProtocol!
    
    var categoryMovies: [LocalCategory: [MovieRepoModel]]!
        
    init() {
        self.networkDataSource = MovieNetworkDataSource.shared
        self.userDefaultsDataSource = UserDefaultsDataSource.shared
        
        categoryMovies = [:]
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchPopularMovies { [weak self] result in
            self?.mapResult(result: result, category: .popular, completion: completion)
        }
    }
    
    func fetchTrending(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        var today = false
        var week = false
        networkDataSource.fetchTrendingToday { [weak self] result in
            guard let self = self else { return }
            
            today = true
            switch result {
            case .success(let movies):
                let mappedMovies: [MovieRepoModel] = movies.map {
                    MovieRepoModel(
                        fromModel: $0,
                        isFavorite: self.userDefaultsDataSource.isFavorite(movieId: $0.identifier),
                        withGenre: Genre.day.rawValue)
                }
                if today, week {
                    self.categoryMovies[.trending]?.append(contentsOf: mappedMovies)
                    completion(.success(self.categoryMovies[.trending] ?? []))
                } else {
                    self.categoryMovies[.trending] = mappedMovies
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        networkDataSource.fetchTrendingThisWeek { [weak self] result in
            week = true
            switch result {
            case .success(let movies):
                let mappedMovies: [MovieRepoModel] = movies.map {
                    MovieRepoModel(
                        fromModel: $0,
                        isFavorite: self?.userDefaultsDataSource.isFavorite(movieId: $0.identifier) ?? false,
                        withGenre: Genre.week.rawValue)
                }
                if today, week {
                    self?.categoryMovies[.trending]?.append(contentsOf: mappedMovies)
                    completion(.success(self?.categoryMovies[.trending] ?? []))
                } else {
                    self?.categoryMovies[.trending] = mappedMovies
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchTopRatedMovies { [weak self] result in
            self?.mapResult(result: result, category: .topRated, completion: completion)
        }
    }
    
    func fetchMovieDetails(for movieId: Int, completion: @escaping(Result<MovieRepoModel, RequestError>) -> Void) {
        networkDataSource.fetchMovieDetails(for: movieId) { [weak self] result in
            self?.mapMovieDetailResult(result: result, completion: completion)
        }
    }
    
    func fetchCast(for movieId: Int, completion: @escaping(Result<[CastRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchCast(for: movieId) { result in
            switch result {
            case .success(let cast):
                let mappedCast = cast.map { CastRepoModel(fromModel: $0) }
                completion(.success(mappedCast))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchRecommendations(for movieId: Int, completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchRecommendations(for: movieId) { result in
            switch result {
            case .success(let movies):
                let mappedMovies = movies.map { MovieRepoModel(fromModel: $0) }
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchReviews(for movieId: Int, completion: @escaping(Result<[ReviewRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchReviews(for: movieId) { result in
            switch result {
            case .success(let reviews):
                let mappedReviews = reviews.map { ReviewRepoModel(fromModel: $0) }
                completion(.success(mappedReviews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func toggleFavorite(_ movieId: Int) {
        userDefaultsDataSource.toggleFavorite(movieId)
        
        updateCategoryMovies()
    }
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieRepoModel] {
        var movies: [MovieRepoModel]
        movies = categoryMovies[category]?.filter {
            $0.genreIds?.contains(genreId) ?? false
        } ?? []
        return movies
    }
    
    func getMovie(with movieId: Int) -> MovieRepoModel? {
        categoryMovies
            .values
            .flatMap { $0 }
            .first(where: { $0.identifier == movieId })
    }
    
    func getFavoriteMovies() -> [MovieRepoModel] {
        userDefaultsDataSource
                .favorites
                .compactMap { getMovie(with: $0) }
    }

}

extension MovieRepository {
    
    private func mapResult(
        result: Result<[MovieDataModel], RequestError>,
        category: LocalCategory,
        completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void
    ) {
        switch result {
        case .success(let movies):
            let mappedMovies: [MovieRepoModel] = movies.map {
                MovieRepoModel(fromModel: $0, isFavorite: userDefaultsDataSource.isFavorite(movieId: $0.identifier))
            }
            categoryMovies[category] = mappedMovies
            completion(.success(mappedMovies))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func mapMovieDetailResult(
        result: Result<MovieDataModel, RequestError>,
        completion: @escaping(Result<MovieRepoModel, RequestError>) -> Void
    ) {
        switch result {
        case .success(let movie):
            let mappedMovie = MovieRepoModel(
                fromModel: movie,
                isFavorite: userDefaultsDataSource.favorites.contains(movie.identifier))
            completion(.success(mappedMovie))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func updateCategoryMovies() {
        categoryMovies = categoryMovies
            .mapValues { categoryMovies in
                categoryMovies
                    .map { $0.copy(isFavorite: userDefaultsDataSource.favorites.contains($0.identifier)) }
            }
    }
    
}
