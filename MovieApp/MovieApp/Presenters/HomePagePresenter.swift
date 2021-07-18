import Foundation

final class HomePagePresenter {
        
    func presentPopularMovies(completionHandler: @escaping (Result<[Movie]?, RequestError>) -> Void) {
        MovieClient.shared.fetchPopularMovies { result in
            switch result {
            case .success(let fetchedMovies):
                completionHandler(.success(fetchedMovies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
