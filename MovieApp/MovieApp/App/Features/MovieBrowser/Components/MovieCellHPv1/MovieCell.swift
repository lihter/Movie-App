import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    static let reuseIdentifier = String(describing: MovieCell.self)

    let offset: CGFloat = 8
    let movieImageWidth: CGFloat = 97

    var movieTitle: UILabel!
    var movieDescription: UILabel!
    var movieImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(with movie: MovieViewModel) {
        movieTitle.text = movie.title
        movieDescription.text = movie.overview
        movieImageView.kf.setImage(with: movie.posterPath)
    }

}
