import UIKit

extension NewMovieCell: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        contentContainer = UIView()
        addSubview(contentContainer)
        
        movieImageView = UIImageView()
        movieImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        movieImageView.isUserInteractionEnabled = true
        contentContainer.addSubview(movieImageView)
        
        favouriteButton = FavouriteButton()
        favouriteButton.addTarget(self, action: #selector(addToFavourites), for: .touchUpInside)
        contentContainer.addSubview(favouriteButton)
    }
    
    func styleViews() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        
        contentContainer.frame = bounds
        contentContainer.layer.cornerRadius = 10
        contentContainer.layer.masksToBounds = true
        
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill
    }
    
    func defineLayoutForViews() {
        favouriteButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(offset)
        }
        
        movieImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
