import UIKit

class HomePageTwoViewController: UIViewController {
    
    let offset: CGFloat = 4

    var searchBar: MovieSearchBar!
    var categoriesPresenter: CategoriesPresenter!
    var categoriesViewController: CategoriesViewController!
    var searchPresenter: SearchPresenter!
    var searchViewController: SearchViewController!
    var presenter: HomePageTwoPresenter!
    
    init(
        presenter: HomePageTwoPresenter,
        categoriesPresenter: CategoriesPresenter,
        searchPresenter: SearchPresenter
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.categoriesPresenter = categoriesPresenter
        self.searchPresenter = searchPresenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()

        searchBar.setDelegate(delegate: self)
    }
    
}

extension HomePageTwoViewController: MovieSearchBarDelegate {
    
    func textDidChange(to text: String) {
        if text.lengthOfBytes(using: .utf8) > 2 {
            searchPresenter.getSearchedMovies(searchQuery: text)
        }
    }
    
    func editingEnded() {
        categoriesViewController.view.isHidden = false
        searchViewController.view.isHidden = true
    }
    
    func editingStarted() {
        categoriesViewController.view.isHidden = true
        searchViewController.view.isHidden = false
    }
    
}

