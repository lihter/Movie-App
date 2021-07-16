import Foundation

final class HomePagePresenter {
    
    var movies: [Movie]? = nil
    
    func presentMovies() -> [Movie]? {
        let movieNetworkClient = NetworkClient()
        
        movieNetworkClient.fetchPopularMovies { result in
            switch result {
            case .success(let fetchedMovies):
                self.movies = fetchedMovies
            case .failure(let error):
                print(error)
            }
        }
        
        return movies
    }
    
}
