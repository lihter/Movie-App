import UIKit

class CategoryCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CategoryCell.self)
    static let height: CGFloat = 270
    
    let offset: CGFloat = 4
    
    var movies: [MovieViewModel]?
    
    var categoryLabel: UILabel!
    var subcategoriesView: SubcategoryView!
    var flowLayout: UICollectionViewFlowLayout!
    var moviesCollectionView: UICollectionView!
    
    var collectionViewOffset: CGFloat {
        set { moviesCollectionView.contentOffset.x = newValue }
        get { moviesCollectionView.contentOffset.x }
    }
    
    public var getSubcategories: ((LocalCategory) -> [LocalSubcategory])!
    public var getSubcategoryMovies: ((LocalSubcategory) -> [MovieViewModel])!
    public var showDetailScreen: ((Int) -> ())!
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildViews()
        setupCollectionView()
        
        subcategoriesView.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        moviesCollectionView.register(NewMovieCell.self, forCellWithReuseIdentifier: NewMovieCell.reuseIdentifier)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.setContentOffset(moviesCollectionView.contentOffset, animated: false)
    }
    
    func populate(with category: LocalCategory?) {
        guard let category = category else { return }
        
        categoryLabel.text = category.title
        subcategoriesView.populate(with: getSubcategories(category))
    }

}

extension CategoryCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
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
            
            self.showDetailScreen(movieId)
        }
        cell.populate(withMovie: movie)
        return cell
    }
    
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return NewMovieCell.cellSize
    }
    
}

extension CategoryCell: CategoryCellDelegate {
    
    func changeSubcategory(to subcategory: LocalSubcategory?) {
        guard let subcategory = subcategory else { return }
        
        movies = getSubcategoryMovies(subcategory)
        moviesCollectionView.reloadData()
        moviesCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
}
