import Combine
import Foundation

final class FavoritesPresenter {

    private let router: AppRouter!
    private let useCase: MoviesUseCaseProtocol!

    init (router: AppRouter, useCase: MoviesUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

    var favoriteMovies: AnyPublisher<[MovieViewModel], Never> {
        useCase
            .favoriteMovies
            .map { $0.map { MovieViewModel(fromModel: $0) } }
            .receiveOnMain()
    }

    func showDetailScreen(for movieId: Int) {
        router.showDetailScreen(for: movieId)
    }

    func toggleFavorite(_ movieId: Int) {
        useCase.toggleFavorite(movieId)
    }

}
