import Combine
import UIKit

class HomePageViewController: UIViewController {
    
    let offset: CGFloat = 4
    var searchBar: MovieSearchBar!
    var categoriesPresenter: CategoriesPresenter!
    var categoriesViewController: CategoriesViewController!
    var searchPresenter: SearchPresenter!
    var searchViewController: SearchViewController!
    var presenter: HomePagePresenter!
        
    private var disposables = Set<AnyCancellable>()
    private var searchDisposables = Set<AnyCancellable>()
    
    init(
        presenter: HomePagePresenter,
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
        bindViews()
    }
    
    private func bindViews() {
        searchBar
            .searchTextField
            .textPublisher()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchString in
                guard let self = self else { return }
                
                let searchPublisher = self.presenter.search(for: searchString)
                searchPublisher
                    .sink { [weak self] in
                        self?.searchViewController.applySnapshot(with: $0)
                    }
                    .store(in: &self.searchDisposables)
            }
            .store(in: &disposables)
    }
    
}

extension HomePageViewController: MovieSearchBarDelegate {
    
    func editingEnded() {
        categoriesViewController.view.isHidden = false
        searchViewController.view.isHidden = true
    }
    
    func editingStarted() {
        categoriesViewController.view.isHidden = true
        searchViewController.view.isHidden = false
    }
    
}

