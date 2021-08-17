import Foundation
import UIKit

final class MovieDetailPresenter {
    
    private weak var delegate: MovieDetailDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    let movieId: Int!
    
    var isFavorite: Bool {
        guard let movie = useCase.getMovie(with: movieId) else { return false }
        
        return movie.isFavorite
    }
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter, for movieId: Int) {
        self.useCase = useCase
        self.router = router
        self.movieId = movieId
    }
    
    func setDelegate(delegate: MovieDetailDelegate) {
        self.delegate = delegate
    }
    
    func fetchAll() {
        getMovieDetails()
        getOverview()
        getMostPopularCast()
        getRecommendations()
        getReview()
    }
    
    func getMovieDetails() {
        useCase.getMovieDetails(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                self.delegate?.fillDetailTitleView(with: DetailTitleViewModel(fromModel: movie))
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getOverview() {
        useCase.getMovieOverview(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let overview):
                self.delegate?.fillOverview(with: overview)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
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
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func favoritePressed() {
        useCase.toggleFavorite(movieId)
        
        delegate?.reloadData()
    }
    
}
