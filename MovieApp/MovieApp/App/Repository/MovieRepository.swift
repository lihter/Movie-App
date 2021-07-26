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
    
}

extension MovieRepository {
    
    private func mapMovies(_ movies: [MovieDataModel]?) -> [MovieRepoModel]?{
        return movies?.map {
            return MovieRepoModel(fromModel: $0)
        }
    }
    
}
