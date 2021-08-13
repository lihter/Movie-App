import UIKit

class FavoritesViewController: UIViewController {
    
    let offset: CGFloat = 4
    
    var movies: [MovieViewModel]!
    
    var favouritesLabel: UILabel!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var presenter: FavoritesPresenter!
    
    public var showDetailScreen: ((Int) -> ())!
    
    init(presenter: FavoritesPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
        
        movies = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.register(NewMovieCell.self, forCellWithReuseIdentifier: NewMovieCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setContentOffset(collectionView.contentOffset, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupCollectionView()
        
        presenter.getFavouriteMovies()
    }
    
}

extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewMovieCell.reuseIdentifier,
                for: indexPath) as? NewMovieCell,
            let movie = movies?[indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        cell.showDetailScreen = { [weak self] movieId in
            guard let self = self else { return }
            
            self.presenter.showDetailScreen(for: movieId)
        }
        cell.populate(withMovie: movie)
        return cell
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

extension FavoritesViewController: FavoriteDelegate {
    
    func showMovies(_ movies: [MovieViewModel]) {
        self.movies = movies
        collectionView.reloadData()
    }
    
}
