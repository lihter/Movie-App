import UIKit

extension ReviewView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        socialLabel = UILabel()
        addSubview(socialLabel)
        
        titleLabel = UILabel()
        addSubview(titleLabel)
        
        writtenByLabel = UILabel()
        addSubview(writtenByLabel)
        
        reviewLabel = UILabel()
        addSubview(reviewLabel)
        
        profileImageView = UIImageView()
        addSubview(profileImageView)
    }
    
    func styleViews() {
        backgroundColor = .clear
        
        socialLabel.text = "Social"
        socialLabel.font = .heading1
        socialLabel.textColor = .primaryBlue
        
        titleLabel.font = .bold(size: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "A review written by \(review.author)"
        
        let text = NSMutableAttributedString(string: "Written by \(review.author) on \(review.createdAt)")
        text.setAttributes(
            [.font: UIFont.regularMedium, .foregroundColor: UIColor.secondaryGray],
            range: NSMakeRange(0, text.length))
        text.setAttributes(
            [.font: UIFont.regularMedium, .foregroundColor: UIColor.black],
            range: NSMakeRange(11, review.author.lengthOfBytes(using: .utf8)))
        writtenByLabel.attributedText = text
        writtenByLabel.numberOfLines = 0
        writtenByLabel.lineBreakMode = .byWordWrapping
        writtenByLabel.textAlignment = .left
        writtenByLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)
        
        reviewLabel.font = .semiBold(size: 14)
        reviewLabel.textColor = .secondaryGray
        reviewLabel.textAlignment = .left
        reviewLabel.numberOfLines = 0
        reviewLabel.lineBreakMode = .byWordWrapping
        reviewLabel.text = review.content
        reviewLabel.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)

        profileImageView.kf.setImage(with: review.profileImagePath)
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = imageSize.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func defineLayoutForViews() {
        socialLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(socialLabel.snp.bottom).offset(5 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
            $0.width.equalTo(imageSize.width)
            $0.height.equalTo(imageSize.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(socialLabel.snp.bottom).offset(5 * offset)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(4 * offset)
            $0.trailing.equalToSuperview().inset(4 * offset)
        }
        
        writtenByLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3 * offset)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(4 * offset)
            $0.trailing.equalToSuperview().inset(4 * offset)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(writtenByLabel.snp.bottom).offset(6 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
            $0.trailing.equalToSuperview().inset(4 * offset)
            $0.height.lessThanOrEqualTo(290)
        }
    }
    
}
