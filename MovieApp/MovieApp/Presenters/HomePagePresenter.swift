import Foundation

final class HomePagePresenter {
        
    func getPopularMovies(completion: @escaping (Result<[MovieViewModel]?, RequestError>) -> Void) {
        MovieClient.shared.fetchPopularMovies { result in
            switch result {
            case .success(let fetchedMovies):
                let movies: [MovieViewModel]? = fetchedMovies?.map {
                    return MovieViewModel(identifier: $0.identifier, title: $0.title, overview: $0.overview, posterPath: $0.posterPath)
                } ?? nil
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
