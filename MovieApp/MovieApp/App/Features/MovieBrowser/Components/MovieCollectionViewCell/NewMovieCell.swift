import UIKit
import Kingfisher

class NewMovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: NewMovieCell.self)
    static let cellSize = CGSize(width: 122, height: 179)
    
    var movieId: Int? = nil
    
    let offset: CGFloat = 8
    
    var movieImageView: UIImageView!
    var favouriteButton: FavouriteButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(withMovie movie: MovieViewModel) {
        movieId = movie.identifier
        movieImageView.kf.setImage(with: movie.posterPath)
    }
    
    @objc func addToFavourites() {
        print("Adding movie with id \(movieId ?? -1) to favourites.")
    }
    
    @objc func imageTapped() {
        print("Selected movie with id \(movieId ?? -1)")
    }
    
}
