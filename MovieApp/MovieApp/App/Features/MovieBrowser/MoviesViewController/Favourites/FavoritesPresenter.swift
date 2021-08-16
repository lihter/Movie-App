import Foundation

final class FavoritesPresenter {
    
    private weak var delegate: FavoriteDelegate?
    private let router: AppRouter!
    private let useCase: MoviesUseCaseProtocol!
    
    init (router: AppRouter, useCase: MoviesUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

    func setDelegate(delegate: FavoritesViewController) {
        self.delegate = delegate
    }
    
    func getFavouriteMovies() {
        useCase.getFavoriteMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                let mappedMovies = movies.map { MovieViewModel(fromModel: $0) }
                self.delegate?.showMovies(mappedMovies)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func showDetailScreen(for movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
    func toggleFavorite(_ movieId: Int) {
        useCase.toggleFavorite(movieId)
        
        delegate?.reloadData()
    }
    
}
