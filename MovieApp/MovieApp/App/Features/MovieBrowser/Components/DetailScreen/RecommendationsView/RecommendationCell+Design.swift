import UIKit

extension RecommendationCell: DesignProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        posterImageView = UIImageView()
        contentView.addSubview(posterImageView)

        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
    }

    func styleViews() {
        backgroundColor = .clear

        contentView.layer.masksToBounds = true

        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true

        nameLabel.font = .regularBold
        nameLabel.textColor = .primaryBlue
        nameLabel.textAlignment = .left
        nameLabel.sizeToFit()
    }

    func defineLayoutForViews() {
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(85)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

}
