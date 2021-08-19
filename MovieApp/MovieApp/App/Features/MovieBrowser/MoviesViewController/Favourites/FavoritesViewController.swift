import Combine
import UIKit

class FavoritesViewController: UIViewController {
    
    let offset: CGFloat = 4
    
//    var movies: [MovieViewModel]!
    
    var disposables = Set<AnyCancellable>()
    typealias DataSource = UICollectionViewDiffableDataSource<FavoritesSection, MovieViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, MovieViewModel>
    lazy var dataSource = makeDataSource()
    
    var favouritesLabel: UILabel!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var presenter: FavoritesPresenter!
    
    init(presenter: FavoritesPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
        
//        movies = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.register(NewMovieCell.self, forCellWithReuseIdentifier: NewMovieCell.reuseIdentifier)
//        collectionView.dataSource = self
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
                
                cell.showDetailScreen = { [weak self] movieId in
                    guard let self = self else { return }
                    
                    self.presenter.showDetailScreen(for: movieId)
                }
                cell.favoritePressed = { [weak self] movieId in
                    guard let self = self else { return }
                    
                    self.presenter.toggleFavorite(movieId)
                }
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

//extension FavoritesViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        movies.count
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        guard
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: NewMovieCell.reuseIdentifier,
//                for: indexPath) as? NewMovieCell,
//            let movie = movies?[indexPath.item]
//        else {
//            return UICollectionViewCell()
//        }
//
//        cell.showDetailScreen = { [weak self] movieId in
//            guard let self = self else { return }
//
//            self.presenter.showDetailScreen(for: movieId)
//        }
//        cell.favoritePressed = { [weak self] movieId in
//            guard let self = self else { return }
//
//            self.presenter.toggleFavorite(movieId)
//        }
//        cell.populate(withMovie: movie)
//        return cell
//    }
//
//}

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

extension FavoritesViewController: FavoriteDelegate {
    
    func showMovies(_ movies: [MovieViewModel]) {
//        self.movies = movies
//        collectionView.reloadData()
    }
    
    func reloadData() {
        //presenter.getFavouriteMovies()
    }
    
}
