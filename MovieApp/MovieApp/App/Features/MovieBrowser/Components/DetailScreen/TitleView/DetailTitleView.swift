import UIKit

class DetailTitleView: UIView {

    static let height = 300

    let offset: CGFloat = 4

    var backgroundImageView: UIImageView!
    var gradientView: UIView!
    var titleLabel: UILabel!
    var releaseDateLabel: UILabel!
    var genresLabel: UILabel!
    var durationLabel: UILabel!
    var gradientLayer: CAGradientLayer!
    var favouritesButton: FavouriteButton!
    var progressBar: ProgressBarView!
    var isFavorite: Bool! {
        didSet {
            if isFavorite {
                favouritesButton.setImage(UIImage(with: .favouriteIconFilled), for: .normal)
            } else {
                favouritesButton.setImage(UIImage(with: .favouriteIcon), for: .normal)
            }
        }
    }

    public var favoritePressed: (() -> Void)!

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(with movieDetails: DetailTitleViewModel) {
        backgroundImageView.kf.setImage(with: movieDetails.posterPath)

        let text = NSMutableAttributedString(string: "\(movieDetails.title) (\(movieDetails.year))")
        text.addAttributes(
            [.font: UIFont.heading2regular, .foregroundColor: UIColor.white],
            range: NSRange(location: text.length - 6, length: 6))
        titleLabel.attributedText = text
        releaseDateLabel.text = movieDetails.releaseDate
        genresLabel.text = movieDetails.genres.joined(separator: ", ")
        durationLabel.text = movieDetails.duration
        isFavorite = movieDetails.isFavorite

        progressBar.setPercentage(to: movieDetails.userScore)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: Int(UIScreen.main.bounds.width) + 1,
            height: DetailTitleView.height)
    }

    @objc func favoriteButtonPressed() {
        favoritePressed()
    }

}
