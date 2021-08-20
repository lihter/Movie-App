import Combine
import UIKit

class FavoritesViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<FavoritesSection, MovieViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, MovieViewModel>
    
    let offset: CGFloat = 4
    
    var favouritesLabel: UILabel!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var presenter: FavoritesPresenter!
    lazy var dataSource = makeDataSource()
    
    private var disposables = Set<AnyCancellable>()
    
    init(presenter: FavoritesPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.register(NewMovieCell.self, forCellWithReuseIdentifier: NewMovieCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.setContentOffset(collectionView.contentOffset, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupCollectionView()
        
        bindViews()
    }
    
    private func bindViews() {
        presenter
            .favoriteMovies
            .sink { [weak self] in
                self?.applySnapshot(with: $0)
            }
            .store(in: &disposables)
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: NewMovieCell.reuseIdentifier,
                        for: indexPath) as? NewMovieCell
                else {
                    return UICollectionViewCell()
                }

                cell
                    .movieImageView
                    .throttledTapGesture()
                    .sink { [weak self] _ in
                        self?.presenter.showDetailScreen(for: movie.identifier)
                    }
                    .store(in: &cell.disposables)
                
                cell
                    .favouriteButton
                    .throttledTap()
                    .sink { [weak self] _ in
                        self?.presenter.toggleFavorite(movie.identifier)
                    }
                    .store(in: &cell.disposables)
                
                cell.populate(withMovie: movie)
                return cell
            })
        return dataSource
    }
    
    private func applySnapshot(with movies: [MovieViewModel], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let numberOfCellsInRow: CGFloat = 3
        let margin = 4 * offset
        let spacing = 4 * offset
        let oneCellWidth = (view.bounds.width - 2 * margin - (numberOfCellsInRow - 1) * spacing) / numberOfCellsInRow
        let height = NewMovieCell.cellSize.height / NewMovieCell.cellSize.width * oneCellWidth
        return CGSize(width: oneCellWidth, height: height)
    }
    
}
