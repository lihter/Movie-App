import UIKit
import Resolver

class AppModule {

    init(container: Resolver) {
        registerAllServices(in: container)
    }

    func start(in window: UIWindow?, container: Resolver) {
        let router: AppRouter = container.resolve()
        router.start(in: window)
    }

}

extension AppModule {

    func registerAllServices(in container: Resolver) {
        registerRouter(in: container)
        registerBaseClient(in: container)
        registerMovieClient(in: container)
        registerNetworkDataSource(in: container)
        registerLocalDataSource(in: container)
        registerUserDefaultsDataSource(in: container)
        registerRepository(in: container)
        registerUseCase(in: container)
        registerHomePage(in: container)
        registerFavorites(in: container)
        registerMovieDetails(in: container)
    }

    private func registerRouter(in container: Resolver) {
        container
            .register { AppRouter(container: container) }
            .scope(.application)
    }

    private func registerBaseClient(in container: Resolver) {
        container
            .register { NetworkClient() }
            .implements(NetworkClientProtocol.self)
            .scope(.application)
    }

    private func registerMovieClient(in container: Resolver) {
        container
            .register { MovieClient() }
            .implements(MovieClientProtocol.self)
            .scope(.application)
    }

    private func registerNetworkDataSource(in container: Resolver) {
        container
            .register { MovieNetworkDataSource() }
            .implements(MovieNetworkDataSourceProtocol.self)
            .scope(.application)
    }

    private func registerLocalDataSource(in container: Resolver) {
        container
            .register { MovieLocalDataSource() }
            .implements(MovieLocalDataSourceProtocol.self)
            .scope(.application)
    }

    private func registerUserDefaultsDataSource(in container: Resolver) {
        container
            .register { UserDefaultsDataSource() }
            .implements(UserDefaultsDataSourceProtocol.self)
            .scope(.application)
    }

    private func registerRepository(in container: Resolver) {
        container
            .register { MovieRepository() }
            .implements(MovieRepositoryProtocol.self)
            .scope(.application)
    }

    private func registerUseCase(in container: Resolver) {
        container
            .register { MoviesUseCase() }
            .implements(MoviesUseCaseProtocol.self)
            .scope(.application)
    }

    private func registerHomePage(in container: Resolver) {
        container
            .register { HomePagePresenter() }
            .scope(.unique)

        container
            .register { CategoriesPresenter() }
            .scope(.unique)

        container
            .register { SearchPresenter() }
            .scope(.unique)

        container
            .register { HomePageViewController() }
            .scope(.unique)
    }

    private func registerFavorites(in container: Resolver) {
        container
            .register { FavoritesPresenter() }
            .scope(.unique)

        container
            .register { FavoritesViewController() }
            .scope(.unique)
    }

    private func registerMovieDetails(in container: Resolver) {
        container
            .register { MovieDetailPresenter() }
            .scope(.unique)

        container
            .register { MovieDetailViewController() }
            .scope(.unique)
    }

}
