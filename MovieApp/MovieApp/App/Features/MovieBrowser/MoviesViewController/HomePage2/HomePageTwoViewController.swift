import UIKit

class HomePageTwoViewController: UIViewController {
    
    let offset: CGFloat = 4
    
    var navigationView: MovieAppNavigationView!
    var searchBar: MovieSearchBar!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
    }
    
}
