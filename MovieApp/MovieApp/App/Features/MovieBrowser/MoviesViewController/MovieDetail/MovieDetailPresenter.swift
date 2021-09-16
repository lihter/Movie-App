import Combine
import Foundation
import UIKit
import Resolver

final class MovieDetailPresenter {

    @Injected private var useCase: MoviesUseCaseProtocol
    @Injected private var router: AppRouter

    var movieId: Int!

    func setMovieId(_ id: Int) {
        movieId = id
    }

    var details: AnyPublisher<DetailViewModel, Never> {
        let castAndCrewPubliser: AnyPublisher<CastAndCrewViewModel, Never> = Publishers
            .CombineLatest(mostPopularCast, crew)
            .map { cast, crew in
                CastAndCrewViewModel(cast: cast, crew: crew)
            }
            .eraseToAnyPublisher()

        return Publishers
            .CombineLatest4(movieDetails, castAndCrewPubliser, recommendations, review)
            .map { titleDetails, castAndCrew, recommendations, review in
                DetailViewModel(
                    titleDetails: titleDetails,
                    castAndCrew: castAndCrew,
                    recommendations: recommendations,
                    review: review)
            }
            .receiveOnMain()
    }

    private var movieDetails: AnyPublisher<DetailTitleViewModel, Never> {
        useCase
            .getMovieDetails(for: movieId)
            .map { DetailTitleViewModel(fromModel: $0) }
            .eraseToAnyPublisher()
    }

    private var mostPopularCast: AnyPublisher<[CastViewModel], Never> {
        useCase
            .getMostPopularCast(for: movieId)
            .map { $0.map { CastViewModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    private var crew: AnyPublisher<[CrewViewModel], Never> {
        useCase
            .getCrew(for: movieId)
            .map { $0.map { CrewViewModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    private var recommendations: AnyPublisher<[MovieViewModel], Never> {
        useCase
            .getRecommendations(for: movieId)
            .map { $0.map { MovieViewModel(fromModel: $0) } }
            .eraseToAnyPublisher()
    }

    private var review: AnyPublisher<ReviewViewModel?, Never> {
        useCase
            .fetchReviews(for: movieId)
            .map { review in
                guard let review = review else {
                    return nil
                }

                return ReviewViewModel(fromModel: review) }
            .eraseToAnyPublisher()
    }

    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }

    func favoritePressed() {
        useCase.toggleFavorite(movieId)
    }

}
