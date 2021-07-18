import Foundation

final class HomePagePresenter {
        
    func getPopularMovies(completion: @escaping (Result<[Movie]?, RequestError>) -> Void) {
        MovieClient.shared.fetchPopularMovies { result in
            switch result {
            case .success(let fetchedMovies):
                completion(.success(fetchedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
