import Combine
import Resolver

final class HomePagePresenter {

    @Injected private var useCase: MoviesUseCaseProtocol
    @Injected private var router: AppRouter

    func search(for searchText: String) -> AnyPublisher<[MovieViewModel], Never> {
        useCase
            .getSearchedMovies(searchQuery: searchText)
            .map { $0.map { MovieViewModel(fromModel: $0) } }
            .receiveOnMain()
    }

}
