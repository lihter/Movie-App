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
        
        progressBar = ProgressBarView()
        addSubview(progressBar)
    }
    
    func styleViews() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width) + 1, height: DetailTitleView.height)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
                
        titleLabel.textColor = .white
        titleLabel.font = .heading2
        
        yearLabel.textColor = .white
        yearLabel.font = .heading2regular
        
        releaseDateLabel.textColor = .white
        releaseDateLabel.font = .regularMedium
        
        genresLabel.textColor = .white
        genresLabel.font = .regularMedium
        
        durationLabel.textColor = .white
        durationLabel.font = .smallBold
    }
    
    func defineLayoutForViews() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalTo(backgroundImageView.snp.edges)
        }
                
        favouritesButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        genresLabel.snp.makeConstraints {
            $0.bottom.equalTo(favouritesButton.snp.top).offset(-4 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.bottom.equalTo(genresLabel.snp.top).offset(-2 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        durationLabel.snp.makeConstraints {
            $0.bottom.equalTo(genresLabel.snp.bottom)
            $0.leading.equalTo(genresLabel.snp.trailing).offset(2 * offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(releaseDateLabel.snp.top).offset(-3 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
        }
        
        yearLabel.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(offset)
        }
        
        progressBar.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.top).offset(-3 * offset - 21)
            $0.leading.equalToSuperview().offset(4 * offset + 21)
        }
    }
    
}
