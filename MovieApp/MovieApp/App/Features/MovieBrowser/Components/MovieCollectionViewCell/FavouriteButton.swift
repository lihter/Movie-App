import UIKit

class FavouriteButton: UIButton {
    
    let size: CGFloat = 32
        
    init() {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension FavouriteButton: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {}
    
    func styleViews() {
        imageView?.contentMode = .scaleAspectFit
        setBackgroundImage(UIImage(with: .favButtonBackground), for: .normal)
    }
    
    func defineLayoutForViews() {
        imageView?.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(size / 2)
        }
    }
    
}
