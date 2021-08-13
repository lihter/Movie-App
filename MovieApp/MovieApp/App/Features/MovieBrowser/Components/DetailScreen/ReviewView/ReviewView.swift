import UIKit

class ReviewView: UIView {
    
    static let height: CGFloat = 420
    
    let offset: CGFloat = 4
    let imageSize: CGSize = CGSize(width: 56, height: 56)
        
    var socialLabel: UILabel!
    var titleLabel: UILabel!
    var writtenByLabel: UILabel!
    var reviewLabel: UILabel!
    var profileImageView: UIImageView!
    
    init() {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(with review: ReviewViewModel) {
        titleLabel.text = "A review written by \(review.author)"

        let text = NSMutableAttributedString(string: "Written by \(review.author) on \(review.createdAt)")
        text.setAttributes(
            [.font: UIFont.regularMedium, .foregroundColor: UIColor.secondaryGray],
            range: NSMakeRange(0, text.length))
        text.setAttributes(
            [.font: UIFont.regularMedium, .foregroundColor: UIColor.black],
            range: NSMakeRange(11, review.author.lengthOfBytes(using: .utf8)))
        writtenByLabel.attributedText = text
        writtenByLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)
        
        reviewLabel.text = review.content
        reviewLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)

        profileImageView.kf.setImage(with: review.profileImagePath)
    }
    
}
