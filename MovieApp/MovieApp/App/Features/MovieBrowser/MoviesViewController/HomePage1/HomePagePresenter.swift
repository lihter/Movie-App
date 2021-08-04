import Foundation

final class HomePagePresenter {
    
    private weak var delegate: HomePageDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func setDelegate(delegate: HomePageDelegate) {
        self.delegate = delegate
    }
    
    func getPopularMovies() {
        useCase.getPopularMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                let moviesViewModel: [MovieViewModel]? = movies.map { MovieViewModel(fromModel: $0) }
                self.delegate?.reloadCollectionView(with: moviesViewModel)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
}
