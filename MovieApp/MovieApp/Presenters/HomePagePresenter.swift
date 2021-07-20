import Foundation

final class HomePagePresenter {
    
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
        useCase.getPopularMovies { result in
            switch result {
            case .success(let movies):
                let moviesViewModel: [MovieViewModel]? = movies?.map {
                    return MovieViewModel(
                        identifier: $0.identifier,
                        title: $0.title,
                        overview: $0.overview,
                        posterPath: "https://image.tmdb.org/t/p/w185\($0.posterPath)")
                } ?? nil
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
