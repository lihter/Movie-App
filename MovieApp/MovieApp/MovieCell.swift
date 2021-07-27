import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MovieCell.self)
    
    let titleFontSize: CGFloat = 16
    let descriptionFontSize: CGFloat = 14
    let offset: CGFloat = 8
    let movieImageWidth: CGFloat = 97
    let movieTitleViewHeight: CGFloat = 20
    
    var movieTitle: UILabel!
    var movieDescription: UILabel!
    var movieImageView: UIImageView!
    var contentContainer: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(withMovie movie: MovieViewModel) {
        movieTitle.text = movie.title
        movieDescription.text = movie.overview
        movieImageView.kf.setImage(with: movie.posterPath)
    }

}
