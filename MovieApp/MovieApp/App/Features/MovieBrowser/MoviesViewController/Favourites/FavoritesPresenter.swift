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
        let mockMovie = MovieViewModel(
            identifier: 550,
            title: "Fight Club",
            overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
            posterPath: URL(string: "https://image.tmdb.org/t/p/original/wigZBAmNrIhxp2FNGOROUAeHvdh.jpg"),
            genreIds: [],
            isFavorite: true)
        delegate?.showMovies(Array(repeating: mockMovie, count: 25))
    }
    
    func showDetailScreen(for movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
    func toggleFavorite(_ movieId: Int) {
        useCase.toggleFavorite(movieId)
    }
    
}
