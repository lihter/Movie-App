import Combine

final class HomePagePresenter {

    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!

    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }

    func search(for searchText: String) -> AnyPublisher<[MovieViewModel], Never> {
        useCase
            .getSearchedMovies(searchQuery: searchText)
            .map { $0.map { MovieViewModel(fromModel: $0) } }
            .receiveOnMain()
    }

}
