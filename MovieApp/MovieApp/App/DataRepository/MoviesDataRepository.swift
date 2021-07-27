<<<<<<< HEAD
import Foundation

=======
>>>>>>> develop
class MoviesDataRepository: MoviesDataRepositoryProtocol {
    
    static let shared: MoviesDataRepositoryProtocol = MoviesDataRepository()
    
    private let networkDataSource: MovieNetworkDataSourceProtocol!
    
    init() {
        self.networkDataSource = MovieNetworkDataSource.shared
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[MovieDataRepositoryModel]?, RequestError>) -> Void) {
<<<<<<< HEAD
        networkDataSource.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let mappedMovies = self?.mapMovies(movies)
=======
        networkDataSource.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                let mappedMovies = self.mapMovies(movies)
>>>>>>> develop
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension MoviesDataRepository {
    
    private func mapMovies(_ movies: [MovieNetworkDataSourceModel]?) -> [MovieDataRepositoryModel]?{
        return movies?.map {
            return MovieDataRepositoryModel(
                identifier: $0.identifier,
                title: $0.title,
                backdropPath: $0.backdropPath,
<<<<<<< HEAD
                posterPath: URL(string: "https://image.tmdb.org/t/p/w185\($0.posterPath)"),
=======
                posterPath: $0.posterPath,
>>>>>>> develop
                overview: $0.overview,
                voteAverage: $0.voteAverage,
                voteCount: $0.voteCount,
                releaseDate: $0.releaseDate,
                genreIds: $0.genreIds,
                budget: $0.budget)
        }
    }
    
}
