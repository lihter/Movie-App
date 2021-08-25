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
            .flatMap { [weak self] text -> AnyPublisher<[MovieViewModel], Never> in
                guard let self = self else { return .empty() }
                
                return self.presenter
                    .search(for: text)
            }
            .sink { [weak self] movies in
                guard let self = self else { return }
                
                self.searchViewController.applySnapshot(with: movies)
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

