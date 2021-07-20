import Foundation

final class HomePagePresenter {
        
    func getPopularMovies(completion: @escaping (Result<[MovieViewModel]?, RequestError>) -> Void) {
        MovieClient.shared.fetchPopularMovies { result in
            switch result {
            case .success(let fetchedMovies):
                let movies: [MovieViewModel]? = fetchedMovies?.map {
                    return MovieViewModel(title: $0.title, overview: $0.overview, posterPath: URL(string: "https://image.tmdb.org/t/p/w185\($0.posterPath)"))
                }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
