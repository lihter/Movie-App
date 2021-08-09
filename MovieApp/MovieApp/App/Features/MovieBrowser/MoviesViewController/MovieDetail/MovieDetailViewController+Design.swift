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
        
        titleView = DetailTitleView()
        contentView.addSubview(titleView)
        
        overviewTitle = UILabel()
        contentView.addSubview(overviewTitle)
        
        overview = UILabel()
        contentView.addSubview(overview)
        
        castView = CastView()
        contentView.addSubview(castView)
        
        review = ReviewView()
        contentView.addSubview(review)
        
        recommendationsView = RecommendationsView()
        contentView.addSubview(recommendationsView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isExclusiveTouch = true
                        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
        navigationItem.titleView = UIImageView(image: UIImage(with: .navigationBarTitleImage))
        
        overviewTitle.text = "Overview"
        overviewTitle.font = .heading1
        overviewTitle.textColor = .primaryBlue
        
        overview.font = .regularMedium
        overview.textColor = .black
        overview.numberOfLines = 0
        overview.lineBreakMode = .byWordWrapping
    }
    
    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.top.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(300)
            $0.leading.trailing.equalToSuperview()
        }
        
        overviewTitle.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(5 * offset)
            $0.leading.equalToSuperview().offset(4 * offset)
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
        
        review.snp.makeConstraints {
            $0.top.equalTo(castView.snp.bottom).offset(10 * offset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(review.reviewLabel.snp.bottom)
        }
        
        recommendationsView.snp.makeConstraints {
            $0.top.equalTo(review.snp.bottom).offset(8 * offset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(RecommendationsView.height)
        }
    }
    
}
