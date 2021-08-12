import UIKit

class MovieDetailViewController: UIViewController {
    
    let offset: CGFloat = 4
        
    var presenter: MovieDetailPresenter!
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var titleView: DetailTitleView!
    var overviewTitle: UILabel!
    var overview: UILabel!
    var castView: CastView!
    var review: ReviewView!
    var recommendationsView: RecommendationsView!
    
    init(presenter: MovieDetailPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        
        presenter.fetchAll()
    }
    
}

extension MovieDetailViewController: MovieDetailDelegate {
    
    func fillDetailTitleView(with movieDetails: DetailTitleViewModel) {
        titleView.populate(with: movieDetails)
    }
    
    func fillOverview(with overview: String) {
        self.overview.text = overview
        self.overview.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)
    }
    
}
