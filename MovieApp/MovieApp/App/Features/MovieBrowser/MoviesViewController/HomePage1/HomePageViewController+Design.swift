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
        flowLayout = UICollectionViewFlowLayout()
        
        filmsCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(filmsCollectionView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
                
        let inset = 3 * offset
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
        flowLayout.minimumLineSpacing = inset
        filmsCollectionView.backgroundColor = .clear
        filmsCollectionView.showsVerticalScrollIndicator = false
    }
    
    func defineLayoutForViews() {
        filmsCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.width.equalToSuperview()
            $0.centerX.equalTo(view.snp.centerX)
        }
    }

}
