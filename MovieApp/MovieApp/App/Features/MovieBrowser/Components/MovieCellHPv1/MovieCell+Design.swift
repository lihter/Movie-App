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
        movieTitle = UILabel()
        contentView.addSubview(movieTitle)
    
        movieDescription = UILabel()
        contentView.addSubview(movieDescription)
        
        movieImageView = UIImageView()
        contentView.addSubview(movieImageView)
    }
    
    func styleViews() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 20
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
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
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
        
        movieImageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(movieImageWidth)
        }
        
        movieTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2 * offset)
            $0.leading.equalTo(movieImageView.snp.trailing).offset(2 * offset)
            $0.trailing.equalToSuperview().inset(offset)
        }
        
        movieDescription.snp.makeConstraints {
            $0.top.equalTo(movieTitle.snp.bottom).offset(offset)
            $0.leading.equalTo(movieImageView.snp.trailing).offset(2 * offset)
            $0.trailing.bottom.equalToSuperview().inset(2 * offset)
            $0.bottom.greaterThanOrEqualToSuperview().inset(2 * offset)
            $0.height.lessThanOrEqualTo(85)
        }
    }

}
