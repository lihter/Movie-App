import UIKit

class DetailTitleView: UIView {
    
    static let height = 300
    
    let offset: CGFloat = 4
    
    var details: DetailTitleViewModel!
    
    var backgroundImageView: UIImageView!
    var gradientView: UIView!
    var titleLabel: UILabel!
    var yearLabel: UILabel!
    var releaseDateLabel: UILabel!
    var genresLabel: UILabel!
    var durationLabel: UILabel!
    var gradientLayer: CAGradientLayer!
    var favouritesButton: FavouriteButton!
    var progressBar: ProgressBarView!
        
    init(getDetailsFunction function: (() -> DetailTitleViewModel?)) {
        super.init(frame: .zero)
        
        details = function()
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width) + 1, height: DetailTitleView.height)
    }
    
}
