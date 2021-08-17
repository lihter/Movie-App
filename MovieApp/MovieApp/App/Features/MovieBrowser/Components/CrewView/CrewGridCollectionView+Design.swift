import UIKit

extension CrewGridCollectionView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        addSubview(collectionView)
    }
    
    func styleViews() {
        backgroundColor = .clear
        
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .clear
    }
    
    func defineLayoutForViews() {
        collectionView.snp.makeConstraints {
            $0.height.equalTo(numberOfRows * 60)
            $0.edges.equalToSuperview()
        }
    }
    
}
