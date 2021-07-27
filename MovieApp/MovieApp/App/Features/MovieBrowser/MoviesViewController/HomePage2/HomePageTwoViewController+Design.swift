import UIKit
import SnapKit

extension HomePageTwoViewController: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        navigationView = MovieAppNavigationView()
        view.addSubview(navigationView)
        
        searchBar = MovieSearchBar()
        view.addSubview(searchBar)
        
        subcategoryView = SubcategoryView()
        view.addSubview(subcategoryView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navigationView.snp.bottom).offset(4 * offset)
        }
        
        subcategoryView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(2 * offset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(SubcategoryView.height)
        }
    }
        
}

extension HomePageTwoViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
