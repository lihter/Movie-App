import Combine

final class SearchPresenter {

    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!

    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }

    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }

}
