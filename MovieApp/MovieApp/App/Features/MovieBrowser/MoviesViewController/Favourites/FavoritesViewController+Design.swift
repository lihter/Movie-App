import UIKit

extension FavoritesViewController: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        favouritesLabel = UILabel()
        view.addSubview(favouritesLabel)
        
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        favouritesLabel.text = "Favorites"
        favouritesLabel.textColor = .primaryBlue
        favouritesLabel.font = .heading1
        
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 4 * offset)
        flowLayout.minimumInteritemSpacing = 2 * offset
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func defineLayoutForViews() {
        favouritesLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(favouritesLabel.snp.bottom).offset(5 * offset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
