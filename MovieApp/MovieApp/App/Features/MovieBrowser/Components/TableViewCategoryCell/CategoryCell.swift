import UIKit

class CategoryCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CategoryCell.self)
    static let height: CGFloat = 270
    
    let categoryTitleFontSize: CGFloat = 20
    let offset: CGFloat = 4
    
    var movies: [MovieViewModel]?
    
    var categoryLabel: UILabel!
    var subcategoriesView: SubcategoryView!
    var flowLayout: UICollectionViewFlowLayout!
    var moviesCollectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildViews()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        moviesCollectionView.register(NewMovieCell.self, forCellWithReuseIdentifier: NewMovieCell.reuseIdentifier)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
    }
    
    func populate(with category: CategoryViewModel) {
        categoryLabel.text = category.categoryTitle
        subcategoriesView.populate(with: category.subcategories)
        movies = category.movies
        moviesCollectionView.reloadData()
    }

}

extension CategoryCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewMovieCell.reuseIdentifier,
                for: indexPath) as? NewMovieCell,
              let movie = movies?[indexPath.item]
        else {
            return UICollectionViewCell()
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

