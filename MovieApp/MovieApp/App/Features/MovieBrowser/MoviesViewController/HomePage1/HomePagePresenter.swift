import Foundation

final class HomePagePresenter: HomePagePresenterProtocol {
    
    private weak var delegate: HomePageDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouterProtocol!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouterProtocol) {
        self.useCase = useCase
        self.router = router
    }
    
    func setDelegate(delegate: HomePageDelegate) {
        self.delegate = delegate
    }
    
    func getPopularMovies() {
<<<<<<< HEAD
        useCase.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                let moviesViewModel: [MovieViewModel]? = self?.mapMovies(movies)
                self?.delegate?.reloadCollectionView(with: moviesViewModel)
=======
        useCase.getPopularMovies { result in
            switch result {
            case .success(let movies):
                let moviesViewModel: [MovieViewModel]? = self.mapMovies(movies)
                self.delegate?.reloadCollectionView(with: moviesViewModel)
>>>>>>> develop
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
}

extension HomePagePresenter {
    
    private func mapMovies(_ movies: [MovieUseCaseModel]?) -> [MovieViewModel]?{
        return movies?.map {
            return MovieViewModel(
                identifier: $0.identifier,
                title: $0.title,
                overview: $0.overview,
                posterPath: $0.posterPath)
        }
    }
    
}
