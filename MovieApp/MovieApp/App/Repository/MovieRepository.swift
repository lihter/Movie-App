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
    
}
