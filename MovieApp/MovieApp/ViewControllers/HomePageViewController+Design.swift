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
        headerImageView = UIImageView()
        
        flowLayout = UICollectionViewFlowLayout()
        
        presenter = HomePagePresenter()

        filmsCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(filmsCollectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .headerColor
        navigationController?.navigationBar.isTranslucent = false

        headerImageView.image = UIImage(named: "AppIcon.pdf")
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
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalToSuperview()
        }
    }

}
