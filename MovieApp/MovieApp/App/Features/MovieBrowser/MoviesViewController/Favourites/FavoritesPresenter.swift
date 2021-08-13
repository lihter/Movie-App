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
        let favoriteMovies = useCase.getFavoriteMovies()
        let mappedMovies = favoriteMovies.map { MovieViewModel(fromModel: $0) }
        delegate?.showMovies(mappedMovies)
    }
    
    func showDetailScreen(for movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
    func toggleFavorite(_ movieId: Int) {
        useCase.toggleFavorite(movieId)
        
        delegate?.reloadData()
    }
    
}
