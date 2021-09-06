import UIKit
import SnapKit

extension HomePageViewController: DesignProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        searchBar = MovieSearchBar()
        view.addSubview(searchBar)

        categoriesViewController = CategoriesViewController(presenter: categoriesPresenter)
        addChild(categoriesViewController)
        view.addSubview(categoriesViewController.view)

        searchViewController = SearchViewController(presenter: searchPresenter)
        searchViewController.view.isHidden = true
        addChild(searchViewController)
        view.addSubview(searchViewController.view)
    }

    func styleViews() {
        view.backgroundColor = .white
    }

    func defineLayoutForViews() {
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5 * offset)
        }

        categoriesViewController.view.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(2 * offset)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        searchViewController.view.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(2 * offset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
