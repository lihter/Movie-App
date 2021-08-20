import Combine
import Foundation
import UIKit

final class MovieDetailPresenter {
    
    private weak var delegate: MovieDetailDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    let movieId: Int!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter, for movieId: Int) {
        self.useCase = useCase
        self.router = router
        self.movieId = movieId
    }
    
    func setDelegate(delegate: MovieDetailDelegate) {
        self.delegate = delegate
    }
    
    func fetchAll() {
        getMostPopularCast()
        getCrew()
        getRecommendations()
        getReview()
    }
    
    var movieDetails: AnyPublisher<DetailTitleViewModel, Never> {
        useCase
            .getMovieDetails(for: movieId)
            .map { DetailTitleViewModel(fromModel: $0) }
            .receiveOnMain()
    }
    func getMostPopularCast() {
        useCase.getMostPopularCast(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let cast):
                let mappedCast = cast.map { CastViewModel(fromModel: $0) }
                self.delegate?.fillCastCV(with: mappedCast)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getCrew() {
        useCase.getCrew(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let crew):
                let mappedCrew = crew.map { CrewViewModel(fromModel: $0) }
                self.delegate?.fillCrew(with: mappedCrew)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getRecommendations() {
        useCase.getRecommendations(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                let mappedMovies = movies.map { MovieViewModel(fromModel: $0) }
                self.delegate?.fillRecommendationsCV(with: mappedMovies)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getReview() {
        useCase.getReview(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let review):
                self.delegate?.fillReview(with: ReviewViewModel(fromModel: review))
            case .failure(let error):
                print("Loading error: \(error.localizedDescription). No review.")
            }
        }
    }
    
    func favoritePressed() {
        useCase.toggleFavorite(movieId)
    }
    
}
