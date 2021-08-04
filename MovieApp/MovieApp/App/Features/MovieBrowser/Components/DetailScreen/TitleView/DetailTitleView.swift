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
    var favouritesButton: FavouriteButton!
    var progressBar: ProgressBarView!
        
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
            range: NSMakeRange(text.length - 6, 6))
        titleLabel.attributedText = text
        releaseDateLabel.text = movieDetails.releaseDate
        genresLabel.text = movieDetails.genres.joined(separator: ", ")
        durationLabel.text = movieDetails.duration
        
        progressBar.setPercentage(to: movieDetails.userScore)
        progressBar.progressAnimation(duration: 1.2)
    }
    
}
