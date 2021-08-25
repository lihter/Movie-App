import Combine
import UIKit

class CategoryCell: UITableViewCell {
    
    typealias DataSource = UICollectionViewDiffableDataSource<CategoryCellSection, MovieViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CategoryCellSection, MovieViewModel>
    
    static let reuseIdentifier = String(describing: CategoryCell.self)
    static let height: CGFloat = 270
    
    let offset: CGFloat = 4
    
    var category: LocalCategory!
    
    var categoryLabel: UILabel!
    var genresView: GenreView!
    var flowLayout: UICollectionViewFlowLayout!
    var moviesCollectionView: UICollectionView!
    lazy var dataSource = makeDataSource()
    
    private var disposables = Set<AnyCancellable>()
    
    var collectionViewOffset: CGFloat {
        set { moviesCollectionView.contentOffset.x = newValue }
        get { moviesCollectionView.contentOffset.x }
    }
    
    public var getGenres: ((LocalCategory) -> [Genre])!
    public var getGenreMovies: ((LocalCategory, Int) -> AnyPublisher<[MovieViewModel], Never>)!
    public var showDetailScreen: ((Int) -> ())!
    public var favoritePressed: ((Int) -> ())!
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildViews()
        setupCollectionView()
        
        genresView.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        moviesCollectionView.register(NewMovieCell.self, forCellWithReuseIdentifier: NewMovieCell.reuseIdentifier)
        moviesCollectionView.delegate = self
        moviesCollectionView.setContentOffset(moviesCollectionView.contentOffset, animated: true)
    }
    
    func populate(with category: LocalCategory?) {
        guard let category = category else { return }
        
        self.category = category
        categoryLabel.text = category.title
        genresView.populate(with: getGenres(category))
    }
    
    private func makeDataSource() -> DataSource {
        DataSource(
            collectionView: moviesCollectionView,
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
                        self?.showDetailScreen(movie.identifier)
                    }
                    .store(in: &cell.disposables)
                
                cell
                    .favouriteButton
                    .throttledTap()
                    .sink { [weak self] _ in
                        self?.favoritePressed(movie.identifier)
                    }
                    .store(in: &cell.disposables)
                
                cell.populate(withMovie: movie)
                return cell
            })
    }
    
    private func applySnapshot(with movies: [MovieViewModel], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        NewMovieCell.cellSize
    }
    
}

extension CategoryCell: CategoryCellDelegate {
    
    func changeGenre(to genre: Genre?, resetOffset: Bool) {
        guard let genre = genre else { return }
        
        disposables = []
        
        getGenreMovies(category, genre.rawValue)
            .sink { [weak self] in
                self?.applySnapshot(with: $0)
            }
            .store(in: &disposables)
        
        if resetOffset {
            moviesCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
}
