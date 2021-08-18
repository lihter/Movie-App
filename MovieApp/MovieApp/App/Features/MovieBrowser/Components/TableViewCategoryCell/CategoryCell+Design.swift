import UIKit

extension CategoryCell: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        categoryLabel = UILabel()
        contentView.addSubview(categoryLabel)
        
        genresView = GenreView()
        contentView.addSubview(genresView)
        
        flowLayout = UICollectionViewFlowLayout()
        moviesCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        contentView.addSubview(moviesCollectionView)
    }
    
    func styleViews() {
        backgroundColor = .clear
        
        categoryLabel.textColor = .primaryBlue
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.font = .heading1
        categoryLabel.textAlignment = .left
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 4 * offset)
        flowLayout.minimumInteritemSpacing = 2 * offset
        
        moviesCollectionView.backgroundColor = .clear
        moviesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func defineLayoutForViews() {
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4 * offset)
            $0.top.equalToSuperview()
        }
        
        genresView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(categoryLabel.snp.bottom).offset(3 * offset)
            $0.height.equalTo(GenreView.height)
        }
        
        moviesCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(genresView.snp.bottom).offset(3 * offset)
            $0.height.equalTo(NewMovieCell.cellSize.height)
        }
    }
    
}
