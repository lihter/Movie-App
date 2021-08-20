import Combine
import Foundation
import UIKit

final class MovieDetailPresenter {
    
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    let movieId: Int!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter, for movieId: Int) {
        self.useCase = useCase
        self.router = router
        self.movieId = movieId
    }
    
    var movieDetails: AnyPublisher<DetailTitleViewModel, Never> {
        useCase
            .getMovieDetails(for: movieId)
            .map { DetailTitleViewModel(fromModel: $0) }
            .receiveOnMain()
    }

    var mostPopularCast: AnyPublisher<[CastViewModel], Never> {
        useCase
            .getMostPopularCast(for: movieId)
            .map { $0.map { CastViewModel(fromModel: $0) } }
            .receiveOnMain()
    }
    
    var crew: AnyPublisher<[CrewViewModel], Never> {
        useCase
            .getCrew(for: movieId)
            .map { $0.map { CrewViewModel(fromModel: $0) } }
            .receiveOnMain()
    }
    
    var recommendations: AnyPublisher<[MovieViewModel], Never> {
        useCase
            .getRecommendations(for: movieId)
            .map { $0.map { MovieViewModel(fromModel: $0) } }
            .receiveOnMain()
    }
    
    var review: AnyPublisher<ReviewViewModel?, Never> {
        useCase
            .fetchReviews(for: movieId)
            .map { review in
                guard let review = review else {
                    return nil
                }
                
                return ReviewViewModel(fromModel: review) }
            .receiveOnMain()
    }
    
    func favoritePressed() {
        useCase.toggleFavorite(movieId)
    }
    
}
