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
    
    init() {
        self.presenter = HomePagePresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        filmsCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        filmsCollectionView.dataSource = self
        filmsCollectionView.delegate = self
    }
    
}

extension HomePageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieCell.reuseIdentifier,
                for: indexPath) as? MovieCell,
            let movie = presenter.movies?[indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        cell.populate(withMovie: movie)
        return cell
    }
    
}

extension HomePageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width - 6 * offset, height: cellHeight)
    }
    
}
