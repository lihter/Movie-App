import UIKit

class FavouriteButton: UIButton {
    
    let size: CGFloat = 32
        
    init() {
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        super.init(frame: rect)
        
        setImage(ImageEnum.favouriteIcon.image, for: .normal)
        setBackgroundImage(ImageEnum.favButtonBackground.image, for: .normal)
        imageView?.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(size / 2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
