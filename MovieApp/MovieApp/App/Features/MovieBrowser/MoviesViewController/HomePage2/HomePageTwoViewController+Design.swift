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
        
        flowLayout = UICollectionViewFlowLayout()
        moviesCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(moviesCollectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 4 * offset)
        flowLayout.minimumInteritemSpacing = 2 * offset
        
        moviesCollectionView.backgroundColor = .clear
        moviesCollectionView.showsHorizontalScrollIndicator = false
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
        
        moviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(subcategoryView.snp.bottom).offset(2 * offset)
            $0.height.equalTo(NewMovieCell.cellSize.height)
            $0.leading.trailing.equalToSuperview()
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
