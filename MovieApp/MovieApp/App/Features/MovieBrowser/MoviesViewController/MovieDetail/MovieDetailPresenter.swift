import Foundation
import UIKit

final class MovieDetailPresenter {
    
    private weak var delegate: MovieDetailDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
        
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func setDelegate(delegate: MovieDetailDelegate) {
        self.delegate = delegate
    }
    
    func fetchAll(for movieId: Int) {
        getMovieDetails(for: movieId)
        getOverview(for: movieId)
    }
    
    func getMovieDetails(for movieId: Int) {
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
    
    func getOverview(for movieId: Int) {
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
    
    func getCast(for movieId: Int) -> [CastViewModel] { }
    
    func getRecommendations(for movieId: Int) -> [MovieViewModel] { }
    
    func getReview(for movieId: Int) -> ReviewViewModel { }
    
}
