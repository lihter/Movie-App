import Foundation
import UIKit
import SnapKit

extension HomePageViewController: DesignProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        let image = UIImage(named: "AppIcon.pdf")
        headerImageView = UIImageView(image: image)
        
        flowLayout = UICollectionViewFlowLayout()
        
        filmsCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(filmsCollectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .headerColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = headerImageView
        
        let inset = 3 * offset
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
        flowLayout.minimumLineSpacing = inset
        filmsCollectionView.backgroundColor = .clear
        filmsCollectionView.showsVerticalScrollIndicator = false
    }
    
    func defineLayoutForViews() {
        filmsCollectionView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
            $0.centerX.equalTo(view.snp.centerX)
        }
    }

}
