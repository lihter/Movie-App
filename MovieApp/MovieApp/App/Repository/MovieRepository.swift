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
    
    func fetchCrew(for movieId: Int, completion: @escaping(Result<[CrewRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchCrew(for: movieId) { result in
            switch result {
            case .success(let crew):
                let mappedCrew = crew.map { CrewRepoModel(fromModel: $0) }
                completion(.success(mappedCrew))
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
    
    func fetchMovies(searchQuery: String, completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchMovies(searchQuery: searchQuery) { result in
            switch result {
            case .success(let movies):
                let mappedMovies = movies.map { MovieRepoModel(fromModel: $0) }
                completion(.success(mappedMovies))
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
    
    func getFavoriteMovies(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        var movies: [MovieRepoModel] = []
        var counter: Int = 0
        
        let completionHandler: (Result<MovieDataModel, RequestError>) -> Void = { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                let mappedMovie = MovieRepoModel(
                    fromModel: movie,
                    isFavorite: self.userDefaultsDataSource.favorites.contains(movie.identifier))
                counter += 1
                movies.append(mappedMovie)
            case .failure(let error):
                print("Error fetching favorites. \(error.localizedDescription)")
            }
                        
            if counter == self.userDefaultsDataSource.favorites.count {
                completion(.success(movies))
            }
        }
        
        userDefaultsDataSource.favorites.forEach { movieId in
            networkDataSource.fetchMovieDetails(for: movieId, completion: completionHandler)
        }
    }
    
    func checkIfFavorite(for movieId: Int) -> Bool {
        userDefaultsDataSource
            .favorites
            .contains(movieId)
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
