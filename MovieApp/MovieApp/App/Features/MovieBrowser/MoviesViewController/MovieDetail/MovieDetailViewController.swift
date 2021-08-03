import UIKit

class MovieDetailViewController: UIViewController {
    
    let offset: CGFloat = 4
    
    var movieId: Int!
    
    var presenter: MovieDetailPresenter!
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var titleView: DetailTitleView!
    var overviewTitle: UILabel!
    var overview: UILabel!
    var castView: CastView!
    var review: ReviewView!
    var recommendationsView: RecommendationsView!
    
    init(presenter: MovieDetailPresenter, withMovieId movieId: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
        self.movieId = movieId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        
        presenter.getMovieDetails(for: movieId)
    }
    
}

extension MovieDetailViewController: MovieDetailDelegate {
    
    func fillDetailTitleView(with movieDetails: DetailTitleViewModel) {
        titleView.populate(with: movieDetails)
    }
    
}
