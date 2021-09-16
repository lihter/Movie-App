import Combine
import Foundation
import Resolver

final class FavoritesPresenter {

    @Injected private var router: AppRouter
    @Injected private var useCase: MoviesUseCaseProtocol

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
