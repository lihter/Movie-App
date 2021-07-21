import UIKit

extension MovieAppNavigationView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        let image = ImageEnum.navigationBarTitleImage.image
        navigationImageView = UIImageView(image: image)
        addSubview(navigationImageView)
        
        backButton = UIButton()
        backButton.setImage(ImageEnum.navigationBarBackButton.image, for: .normal)
        addSubview(backButton)
    }
    
    func styleViews() {
        backgroundColor = .headerColor
        backButton.isHidden = true
    }
    
    func defineLayoutForViews() {
        snp.makeConstraints {
            $0.height.equalTo(barHeight)
        }
        
        navigationImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(9 * offset)
            $0.top.equalToSuperview().offset(10 * offset)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10 * offset)
            $0.height.equalTo(5 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
    }
}
