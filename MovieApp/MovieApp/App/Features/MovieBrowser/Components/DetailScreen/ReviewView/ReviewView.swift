import UIKit

class ReviewView: UIView {
    
    static let height: CGFloat = 420
    
    let offset: CGFloat = 4
    let imageSize: CGSize = CGSize(width: 56, height: 56)
    
    var review: ReviewViewModel!
    
    var socialLabel: UILabel!
    var titleLabel: UILabel!
    var writtenByLabel: UILabel!
    var reviewLabel: UILabel!
    var profileImageView: UIImageView!
    
    init(getReviews: (() -> ReviewViewModel?)) {
        super.init(frame: .zero)
        
        review = getReviews()
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
