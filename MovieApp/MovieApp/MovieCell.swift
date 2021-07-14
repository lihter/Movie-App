import UIKit

class MovieCell: UICollectionViewCell {
    
    static let cellIdentifier = "cellid"
    
    let titleFontSize: CGFloat = 16
    let descriptionFontSize: CGFloat = 14
    let offset: CGFloat = 8
    let movieImageWidth: CGFloat = 97
    let movieTitleViewHeight: CGFloat = 20
    
    var movieTitle: UILabel!
    var movieDescription: UILabel!
    var movieImageView: UIImageView!
    var cellView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(withMovie movie: Movie) {
        movieTitle.text = movie.title
        movieDescription.text = movie.desription
        movieImageView.image = UIImage(named: movie.imageString)
    }

}
