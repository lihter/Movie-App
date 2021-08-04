import Foundation

class MovieRepository: MovieRepositoryProtocol {
    
    static let shared: MovieRepositoryProtocol = MovieRepository()
    
    private let networkDataSource: MovieNetworkDataSourceProtocol!
    
    init() {
        self.networkDataSource = MovieNetworkDataSource.shared
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchPopularMovies { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchTrendingToday { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchTrendingThisWeek { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchTopRatedMovies { [weak self] result in
            self?.mapResult(result: result, completion: completion)
        }
    }
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        networkDataSource.fetchTopRatedTV { [weak self] result in
            self?.mapResult(result: result, completion: completion)
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

}

extension MovieRepository {
    
    private func mapResult(result: Result<[MovieDataModel], RequestError>, completion:@escaping(Result<[MovieRepoModel], RequestError>) -> Void) {
        switch result {
        case .success(let movies):
            let mappedMovies = movies.map { MovieRepoModel(fromModel: $0) }
            completion(.success(mappedMovies))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func mapMovieDetailResult(result: Result<MovieDataModel, RequestError>, completion: @escaping(Result<MovieRepoModel, RequestError>) -> Void) {
        switch result {
        case .success(let movie):
            let mappedMovie = MovieRepoModel(fromModel: movie)
            completion(.success(mappedMovie))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
