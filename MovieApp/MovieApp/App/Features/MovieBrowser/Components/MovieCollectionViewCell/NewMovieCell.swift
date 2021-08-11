import UIKit
import Kingfisher

class NewMovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: NewMovieCell.self)
    static let cellSize = CGSize(width: 122, height: 179)
    
    var movieId: Int!
    
    let offset: CGFloat = 8
    
    var movieImageView: UIImageView!
    var favouriteButton: FavouriteButton!
    var isFavorite: Bool! {
        didSet {
            if isFavorite {
                favouriteButton.setImage(UIImage(with: .favouriteIconFilled), for: .normal)
            } else {
                favouriteButton.setImage(UIImage(with: .favouriteIcon), for: .normal)
            }
        }
    }
    
    public var showDetailScreen: ((Int) -> ())!
    public var favoritePressed: ((Int) -> ())!

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
        isFavorite = movie.isFavorite
    }
    
    @objc func favoriteButtonPressed() {
        favoritePressed(movieId)
    }
    
    @objc func imageTapped() {        
        showDetailScreen(movieId)
    }
    
}
