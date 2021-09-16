import Combine
import UIKit
import Reachability
import Resolver

class MovieDetailViewController: UIViewController {

    let offset: CGFloat = 4

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
    var noConnectionImageView: UIImageView!
    var reachability: Reachability!

    @Injected var presenter: MovieDetailPresenter

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
        hasConnection()
    }

    override func viewWillDisappear(_ animated: Bool) {
        reachability.stopNotifier()
    }

    private func bindViews() {
        presenter
            .details
            .sink { [weak self] in
                self?.setData($0)
            }
            .store(in: &disposables)

        recommendationsView
            .selectedMoviePublisher
            .sink { [weak self] movieId in
                self?.presenter.selectedMovie(withId: movieId)
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

    private func hasConnection() {
        reachability = try? Reachability()

        reachability.whenReachable = { [weak self] _ in
            self?.hideContent(false)
        }

        reachability.whenUnreachable = { [weak self] _ in
            self?.hideContent(true)
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

}
