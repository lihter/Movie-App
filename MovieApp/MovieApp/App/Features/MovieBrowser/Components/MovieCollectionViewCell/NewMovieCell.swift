import Combine
import UIKit
import Kingfisher

class NewMovieCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: NewMovieCell.self)
    static let cellSize = CGSize(width: 122, height: 179)

    let offset: CGFloat = 8

    var disposables = Set<AnyCancellable>()

    var movieImageView: UIImageView!
    var favouriteButton: FavouriteButton!
    var isFavorite: Bool? {
        didSet {
            let icon: BundleImage = isFavorite ?? false ? .favouriteIconFilled : .favouriteIcon
            favouriteButton.setImage(UIImage(with: icon), for: .normal)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposables = Set<AnyCancellable>()
        movieImageView.image = nil
        isFavorite = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(withMovie movie: MovieViewModel) {
        movieImageView.kf.setImage(with: movie.posterPath, placeholder: UIImage(with: .moviePlaceholder))
        isFavorite = movie.isFavorite
    }

}
