import Foundation

class MoviesUseCase: MoviesUseCaseProtocol {
    
    static let shared: MoviesUseCaseProtocol = MoviesUseCase()

    private let moviesDataRepo: MoviesDataRepositoryProtocol!
    
    init() {
        self.moviesDataRepo = MoviesDataRepository.shared
    }
    
    func getPopularMovies(completion: @escaping (Result<[MovieUseCaseModel]?, RequestError>) -> Void) {
        moviesDataRepo.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let mapppedMovies = self?.mapMovies(movies)
                completion(.success(mapppedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension MoviesUseCase {
    
    private func mapMovies(_ movies: [MovieDataRepositoryModel]?) -> [MovieUseCaseModel]? {
        return movies?.map {
            return MovieUseCaseModel(
                identifier: $0.identifier,
                title: $0.title,
                backdropPath: $0.backdropPath,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w185\($0.posterPath)"),
                overview: $0.overview,
                voteAverage: $0.voteAverage,
                voteCount: $0.voteCount,
                releaseDate: $0.releaseDate,
                genreIds: $0.genreIds,
                budget: $0.budget)
        }
    }
    
}

