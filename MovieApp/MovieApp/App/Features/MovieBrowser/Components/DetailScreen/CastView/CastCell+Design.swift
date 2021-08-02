import UIKit

extension CastCell: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        portraitImageView = UIImageView()
        contentView.addSubview(portraitImageView)
        
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        
        characterNameLabel = UILabel()
        contentView.addSubview(characterNameLabel)
    }
    
    func styleViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        portraitImageView.contentMode = .scaleAspectFill
        portraitImageView.clipsToBounds = true
        
        nameLabel.font = .smallBold
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textAlignment = .left
        
        characterNameLabel.font = .smallRegular
        characterNameLabel.textColor = .secondaryGray
        characterNameLabel.numberOfLines = 0
        characterNameLabel.lineBreakMode = .byWordWrapping
        characterNameLabel.textAlignment = .left
    }
    
    func defineLayoutForViews() {
        snp.makeConstraints {
            $0.height.equalTo(CastCell.cellSize.height)
        }
        
        portraitImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(136)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(portraitImageView.snp.bottom).offset(2 * offset)
            $0.leading.equalToSuperview().offset(2 * offset)
            $0.trailing.equalToSuperview().inset(2 * offset)
        }
        
        characterNameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(2 * offset)
            $0.leading.equalToSuperview().offset(2 * offset)
            $0.trailing.equalToSuperview().inset(2 * offset)
        }
    }
    
}
