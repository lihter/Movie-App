import UIKit

extension DetailTitleView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        backgroundImageView = UIImageView()
        addSubview(backgroundImageView)
        
        gradientView = UIView()
        addSubview(gradientView)
        
        gradientLayer = CAGradientLayer()
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        titleLabel = UILabel()
        addSubview(titleLabel)
        
        yearLabel = UILabel()
        addSubview(yearLabel)
        
        releaseDateLabel = UILabel()
        addSubview(releaseDateLabel)
        
        genresLabel = UILabel()
        addSubview(genresLabel)
        
        durationLabel = UILabel()
        addSubview(durationLabel)
        
        favouritesButton = FavouriteButton()
        addSubview(favouritesButton)
        
        progressBar = ProgressBarView(percentage: details.userScore)
        addSubview(progressBar)
    }
    
    func styleViews() {
        backgroundImageView.kf.setImage(with: details.posterPath)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        
        titleLabel.text = details.title
        titleLabel.textColor = .white
        titleLabel.font = .heading2
        
        yearLabel.text = "(\(details.year))"
        yearLabel.textColor = .white
        yearLabel.font = .heading2regular
        
        releaseDateLabel.text = details.releaseDate
        releaseDateLabel.textColor = .white
        releaseDateLabel.font = .regularMedium
        
        genresLabel.text = details.genres.joined(separator: ", ")
        genresLabel.textColor = .white
        genresLabel.font = .regularMedium
        
        durationLabel.text = details.duration
        durationLabel.textColor = .white
        durationLabel.font = .smallBold
        
        progressBar.progressAnimation(duration: 1.2)
    }
    
    func defineLayoutForViews() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalTo(backgroundImageView.snp.edges)
        }
        
        progressBar.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview()
            $0.leading.equalToSuperview().offset(4 * offset + 21)
            $0.trailing.lessThanOrEqualToSuperview().inset(4 * offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(3 * offset + 21)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        yearLabel.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(offset)
            $0.trailing.lessThanOrEqualToSuperview().inset(4 * offset)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
            $0.trailing.lessThanOrEqualToSuperview().inset(4 * offset)
        }
        
        genresLabel.snp.makeConstraints {
            $0.top.equalTo(releaseDateLabel.snp.bottom).offset(2 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        durationLabel.snp.makeConstraints {
            $0.bottom.equalTo(genresLabel.snp.bottom)
            $0.leading.equalTo(genresLabel.snp.trailing).offset(2 * offset)
            $0.trailing.lessThanOrEqualToSuperview().inset(4 * offset)
        }
        
        favouritesButton.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom).offset(4 * offset)
            $0.bottom.equalToSuperview().inset(5 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
            $0.trailing.lessThanOrEqualToSuperview().inset(4 * offset)
        }
    }
    
}
