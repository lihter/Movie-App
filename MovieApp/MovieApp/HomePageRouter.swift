import UIKit

protocol HomePageRouterProtocol {
    
    func showDetailScreen(for movieId: Int)
    
}

final class HomePageRouter {
    
    weak var source: UIViewController?
    
    init(forVC source: UIViewController) {
        self.source = source
    }
    
}

extension HomePageRouter: HomePageRouterProtocol {
    
    func showDetailScreen(for movieId: Int) {
        let vc = MovieDetailViewController(withMovieId: movieId)
                
        source?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
