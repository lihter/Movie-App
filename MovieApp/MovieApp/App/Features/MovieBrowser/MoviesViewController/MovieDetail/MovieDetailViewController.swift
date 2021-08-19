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
        
        presenter
            .movieDetails
            .sink(
                receiveCompletion: { print("Ended with ", $0)},
                receiveValue: { movie in
                    DispatchQueue.main.async {
                        self.titleView.populate(with: movie)
                    }
                })
            .store(in: &disposables)
        
        presenter
            .overview
            .sink(
                receiveCompletion: { print("Ended with ", $0)},
                receiveValue: { text in
                    DispatchQueue.main.async {
                        self.overview.text = text
                    }
                })
            .store(in: &disposables)
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
        titleView.reloadData()
    }
    
    func fillCrew(with crew: [CrewViewModel]) {
        crewGridCollectionView.populate(with: crew)
    }
    
}
