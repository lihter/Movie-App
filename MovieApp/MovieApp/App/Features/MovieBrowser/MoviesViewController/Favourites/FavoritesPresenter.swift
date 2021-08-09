import Foundation

final class FavoritesPresenter {
    
    private weak var delegate: FavoriteDelegate?
    private let router: AppRouter!
    
    init (router: AppRouter) {
        self.router = router
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
            isFavourite: true)
        delegate?.showMovies(Array(repeating: mockMovie, count: 25))
    }
    
    func showDetailScreen(for movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
}
