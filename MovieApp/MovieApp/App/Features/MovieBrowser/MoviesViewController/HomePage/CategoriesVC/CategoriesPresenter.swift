import Combine

final class CategoriesPresenter {

    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!

    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }

    func getCategories() -> [LocalCategory] {
        [.popular, .trending, .topRated]
    }

    func getMovies(for category: LocalCategory, genreId: Int) -> AnyPublisher<[MovieViewModel], Never> {
        useCase
            .getMovies(for: category, genreId: genreId)
            .map { $0.map { MovieViewModel(fromModel: $0) } }
            .receiveOnMain()
    }

    func getGenres(for category: LocalCategory) -> [Genre] {
        if category == .trending {
            return [.day, .week]
        }
        return [.action, .animation, .comedy, .scienceFiction, .thriller]
    }

    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }

    func toggleFavorite(_ movieId: Int) {
        useCase.toggleFavorite(movieId)
    }

}
