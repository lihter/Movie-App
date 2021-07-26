import Foundation
import UIKit
import SnapKit

extension MovieCell: DesignProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        contentContainer = UIView()
        addSubview(contentContainer)

        movieTitle = UILabel()
        contentContainer.addSubview(movieTitle)
    
        movieDescription = UILabel()
        contentContainer.addSubview(movieDescription)
        
        movieImageView = UIImageView()
        contentContainer.addSubview(movieImageView)
    }
    
    func styleViews() {
        backgroundColor = UIColor.clear
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 20
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath

        contentContainer.frame = bounds
        contentContainer.backgroundColor = .white
        contentContainer.layer.cornerRadius = 10
        contentContainer.layer.masksToBounds = true
        
        movieTitle.textColor = .black
        movieTitle.adjustsFontSizeToFitWidth = true
        movieTitle.font = .regularBold
        movieTitle.textAlignment = .left
        
        movieDescription.numberOfLines = 0
        movieDescription.lineBreakMode = .byWordWrapping
        movieDescription.textAlignment = .left
        movieDescription.textColor = .secondaryTextColor
        movieDescription.font = .regularMedium
        
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill
    }
    
    func defineLayoutForViews() {
        movieImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(movieImageWidth)
        }
        
        movieTitle.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(2 * offset)
            $0.trailing.equalToSuperview().inset(1.5 * offset)
            $0.top.equalToSuperview().offset(2 * offset)
            $0.height.equalTo(movieTitleViewHeight)
        }
        
        movieDescription.snp.makeConstraints {
            $0.leading.equalTo(movieImageView.snp.trailing).offset(2 * offset)
            $0.trailing.equalToSuperview().inset(2 * offset)
            $0.top.equalTo(movieTitle.snp.bottom).offset(offset)
            $0.bottom.equalToSuperview().inset(2 * offset)
        }
    }

}
