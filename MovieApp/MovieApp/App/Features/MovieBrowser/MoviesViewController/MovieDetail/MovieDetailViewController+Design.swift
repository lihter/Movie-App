import UIKit

extension MovieDetailViewController: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        titleView = DetailTitleView { [weak self] in
            guard let self = self else { return nil }
            
            return self.presenter.getMovieDetails(for: self.movieId)
        }
        contentView.addSubview(titleView)
        
        overviewTitle = UILabel()
        contentView.addSubview(overviewTitle)
        
        overview = UILabel()
        contentView.addSubview(overview)
        
        castView = CastView { [weak self] in
            guard let self = self else { return [] }
            
            return self.presenter.getCast(for: self.movieId)
        }
        contentView.addSubview(castView)
        
        recommendationsView = RecommendationsView { [weak self] in
            guard let self = self else { return [] }
            
            return self.presenter.getRecommendations(for: self.movieId)
        }
        contentView.addSubview(recommendationsView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isExclusiveTouch = true
                        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
        navigationItem.titleView = UIImageView(image: UIImage(with: .navigationBarTitleImage))
        
        overviewTitle.text = "Overview"
        overviewTitle.font = .heading1
        overviewTitle.textColor = .primaryBlue
        
        overview.text = presenter.getOverview(for: movieId)
        overview.font = .regularMedium
        overview.textColor = .black
        overview.numberOfLines = 0
        overview.lineBreakMode = .byWordWrapping
        overview.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)
    }
    
    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(view.frame.width)
            $0.top.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(300)
            $0.leading.trailing.equalToSuperview()
        }
        
        overviewTitle.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(5 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
            $0.trailing.lessThanOrEqualToSuperview().inset(4 * offset)
        }
        
        overview.snp.makeConstraints {
            $0.top.equalTo(overviewTitle.snp.bottom).offset(3 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
            $0.trailing.equalToSuperview().inset(4 * offset)
        }
        
        castView.snp.makeConstraints {
            $0.top.equalTo(overview.snp.bottom).offset(8 * offset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(CastView.height)
        }
        
        recommendationsView.snp.makeConstraints {
            $0.top.equalTo(castView.snp.bottom).offset(8 * offset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4 * offset)
        }
    }
    
}
