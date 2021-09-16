import Combine
import UIKit
import Resolver

class HomePageViewController: UIViewController {

    let offset: CGFloat = 4
    var searchBar: MovieSearchBar!
    var categoriesViewController: CategoriesViewController!
    var searchViewController: SearchViewController!
    @Injected var presenter: HomePagePresenter
    @Injected var categoriesPresenter: CategoriesPresenter
    @Injected var searchPresenter: SearchPresenter

    private var disposables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()

        searchBar.setDelegate(delegate: self)
        bindViews()
    }

    private func bindViews() {
        searchBar
            .searchTextField
            .textPublisher
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
