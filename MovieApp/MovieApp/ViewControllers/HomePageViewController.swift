import Foundation
import UIKit

class HomePageViewController: UIViewController {

    let offset: CGFloat = 4
    let cellHeight: CGFloat = 142
    
    var headerView: UIView!
    var headerImageView: UIImageView!
    var filmsCollectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    var presenter: HomePagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        filmsCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        filmsCollectionView.dataSource = self
        filmsCollectionView.delegate = self
    }

}

extension HomePageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellIdentifier, for: indexPath) as! MovieCell
        cell.populate(withMovie: presenter.movies[indexPath.item])
        return cell
    }
    
}

extension HomePageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 6 * offset, height: cellHeight)
    }
    
}
