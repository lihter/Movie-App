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
            .movieDetails
            .sink { [weak self] in
                self?.setData($0)
            }
            .store(in: &disposables)
        
        presenter
            .mostPopularCast
            .sink { [weak self] in
                self?.castView.populate(with: $0)
            }
            .store(in: &disposables)
        
        presenter
            .crew
            .sink { [weak self] in
                self?.crewGridCollectionView.populate(with: $0)
            }
            .store(in: &disposables)
        
        presenter
            .recommendations
            .sink { [weak self] in
                self?.recommendationsView.populate(with: $0)
            }
            .store(in: &disposables)
        
        presenter
            .review
            .sink { [weak self] review in
                if let review = review {
                    self?.review.populate(with: review)
                }
            }
            .store(in: &disposables)
    }
    
    private func setData(_ data: DetailTitleViewModel) {
        titleView.populate(with: data)
        
        overview.text = data.overview
        self.overview.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.4)
    }

}
