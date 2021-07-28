import Foundation

class MovieRepository: MovieRepositoryProtocol {
    
    static let shared: MovieRepositoryProtocol = MovieRepository()
    
    private let networkDataSource: MovieNetworkDataSourceProtocol!
    
    init() {
        self.networkDataSource = MovieNetworkDataSource.shared
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieRepoModel]?, RequestError>) -> Void) {
        networkDataSource.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTrendingToday(completion: @escaping(Result<[MovieRepoModel]?, RequestError>) -> Void) {
        networkDataSource.fetchTrendingToday { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTrendingThisWeek(completion: @escaping(Result<[MovieRepoModel]?, RequestError>) -> Void) {
        networkDataSource.fetchTrendingThisWeek { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping(Result<[MovieRepoModel]?, RequestError>) -> Void) {
        networkDataSource.fetchTopRatedMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedTV(completion: @escaping(Result<[MovieRepoModel]?, RequestError>) -> Void) {
        networkDataSource.fetchTopRatedTV { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension MovieRepository {
    
    private func mapMovies(_ movies: [MovieDataModel]?) -> [MovieRepoModel]?{
        return movies?.map {
            return MovieRepoModel(fromModel: $0)
        }
    }
    
}
