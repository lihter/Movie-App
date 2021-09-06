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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        
        bindViews()
    }
    
    private func bindViews() {
        presenter
            .details
            .sink { [weak self] in
                self?.setData($0)
            }
            .store(in: &disposables)
    }

    private func setData(_ data: DetailViewModel) {
        titleView.populate(with: data.titleDetails)
        
        overview.text = data.titleDetails.overview
        self.overview.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)
        
        castView.applySnapshot(with: data.castAndCrew.cast)
        
        crewGridCollectionView.applySnapshot(with: data.castAndCrew.crew)
        
        recommendationsView.applySnapshot(with: data.recommendations)
        
        if let review = data.review {
            self.review.populate(with: review)
        }
    }
    
}
