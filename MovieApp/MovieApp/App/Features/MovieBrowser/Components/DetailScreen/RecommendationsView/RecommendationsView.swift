import UIKit

class RecommendationsView: UIView {
    
    static let height: CGFloat = RecommendationCell.cellSize.height + 40
    
    let offset: CGFloat = 4
    
    var recommendations: [MovieViewModel]!
    
    var recommendationsLabel: UILabel!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    
    init(getRecommendations: (() -> [MovieViewModel])) {
        super.init(frame: .zero)
        
        recommendations = getRecommendations()
        buildViews()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: RecommendationCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension RecommendationsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recommendations?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommendationCell.reuseIdentifier,
                for: indexPath) as? RecommendationCell,
            let movie = recommendations?[indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        cell.populate(withMovie: movie)
        return cell
    }
    
}

extension RecommendationsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
    
}

extension RecommendationsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return RecommendationCell.cellSize
    }
    
}

