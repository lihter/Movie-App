import Foundation
import UIKit

final class MovieDetailPresenter {
    
    private weak var delegate: MovieDetailDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    var movieDetails: MovieDetailViewModel!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func setDelegate(delegate: MovieDetailDelegate) {
        self.delegate = delegate
    }
    
    func getMovieDetails(for movieId: Int) {
        useCase.getMovieDetails(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                self.movieDetails = MovieDetailViewModel(fromModel: movie)
                self.delegate?.fillDetailTitleView(with: DetailTitleViewModel(fromModel: self.movieDetails))
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getOverview(for movieId: Int) -> String { }
    
    func getCast(for movieId: Int) -> [CastViewModel] { }
    
    func getRecommendations(for movieId: Int) -> [MovieViewModel] { }
    
    func getReview(for movieId: Int) -> ReviewViewModel { }
    
}
