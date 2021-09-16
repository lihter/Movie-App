import Combine
import Resolver

final class SearchPresenter {

    @Injected private var useCase: MoviesUseCaseProtocol
    @Injected private var router: AppRouter

    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }

}
