import Combine
import UIKit

class MovieDetailViewController: UIViewController {
    
    let offset: CGFloat = 4
        
    var presenter: MovieDetailPresenter!
    
    var disposables = Set<AnyCancellable>()
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var titleView: DetailTitleView!
    var overviewTitle: UILabel!
    var overview: UILabel!
    var castView: CastView!
    var review: ReviewView!
    var recommendationsView: RecommendationsView!
    var crewGridCollectionView: CrewGridCollectionView!
    
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
        
        bindViews()
    }
    
    private func bindViews() {
        presenter
            .movieDetails
            .sink { [weak self] in
                self?.setData($0)
            }
            .store(in: &disposables)
    }
    
    private func setData(_ data: DetailTitleViewModel) {
        titleView.populate(with: data)
        overview.text = data.overview
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
    
    func fillCastCV(with cast: [CastViewModel]) {
        castView.populate(with: cast)
    }
    
    func fillRecommendationsCV(with movies: [MovieViewModel]) {
        recommendationsView.populate(with: movies)
    }
    
    func fillReview(with review: ReviewViewModel) {
        self.review.populate(with: review)
    }
    
    func reloadData() {
        //titleView.reloadData()
    }
    
    func fillCrew(with crew: [CrewViewModel]) {
        crewGridCollectionView.populate(with: crew)
    }
    
}
