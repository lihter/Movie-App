import UIKit

extension NewMovieCell: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        movieImageView = UIImageView()
        movieImageView.isUserInteractionEnabled = true
        contentView.addSubview(movieImageView)
        
        favouriteButton = FavouriteButton()
        contentView.addSubview(favouriteButton)
    }
    
    func styleViews() {
        backgroundColor = .clear
        layer.cornerRadius = 10

        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
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
