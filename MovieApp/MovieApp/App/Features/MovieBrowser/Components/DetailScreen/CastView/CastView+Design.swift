import UIKit

extension CastView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)
        
        fullCastButton = UIButton()
        addSubview(fullCastButton)
        
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        addSubview(collectionView)
    }
    
    func styleViews() {
        backgroundColor = .clear
        
        titleLabel.text = "Cast's Most Popular"
        titleLabel.font = .heading1
        titleLabel.textColor = .primaryBlue
        
        fullCastButton.setTitle("Full Cast & Crew", for: .normal)
        fullCastButton.setTitleColor(.primaryBlue, for: .normal)
        fullCastButton.titleLabel?.font = .regularSemiBold
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 4 * offset)
        flowLayout.minimumInteritemSpacing = 2 * offset
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        fullCastButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(4 * offset)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(2 * offset)
            $0.height.equalTo(CastCell.cellSize.height + 20)
            $0.bottom.equalToSuperview()
        }
    }
    
}
