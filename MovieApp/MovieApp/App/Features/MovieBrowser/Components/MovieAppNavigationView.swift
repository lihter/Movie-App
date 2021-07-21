import UIKit

class MovieAppNavigationView: UIView {
    
    let offset: CGFloat = 4
    
    var navigationImageView: UIImageView!
    var backButton: UIButton!
    
    var hidesBackButton = true {
        didSet {
            backButton.isHidden = hidesBackButton
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
