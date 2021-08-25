import Combine
import UIKit

class RecommendationsView: UIView {
    
    typealias DataSource = UICollectionViewDiffableDataSource<RecommendationsSection, MovieViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<RecommendationsSection, MovieViewModel>
        
    let offset: CGFloat = 4
        
    var recommendationsLabel: UILabel!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    lazy var dataSource = makeDataSource()
    
    var selectedMovie: ((Int) -> ())!
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        
        buildViews()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: RecommendationCell.reuseIdentifier)
        collectionView.delegate = self
    }

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: RecommendationCell.reuseIdentifier,
                        for: indexPath) as? RecommendationCell
                else {
                    return UICollectionViewCell()
                }
                
                cell.populate(withMovie: movie)
                return cell
            })
        return dataSource
    }
    
    func applySnapshot(with movies: [MovieViewModel], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension RecommendationsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        
        selectedMovie(movie.identifier)
    }
    
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

