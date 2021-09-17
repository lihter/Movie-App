import UIKit

class RecommendationCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: CastCell.self)
    static let cellSize = CGSize(width: 180, height: 115)

    let offset: CGFloat = 4

    var nameLabel: UILabel!
    var posterImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(withMovie movie: MovieViewModel) {
        nameLabel.text = movie.title
        posterImageView.kf.setImage(with: movie.posterPath, placeholder: UIImage(with: .moviePlaceholder))
    }

}
