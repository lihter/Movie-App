import UIKit

final class AppRouter {
    
    private let networkClient: NetworkClientProtocol!
    private let moviesClient: MovieClientProtocol!
    private let moviesNetworkDataSource: MovieNetworkDataSourceProtocol!
    private let moviesRepo: MoviesDataRepositoryProtocol!
    private let moviesUseCase: MoviesUseCaseProtocol!
    
    private let navigationController: UINavigationController!
    
    init() {
        networkClient = NetworkClient.shared
        moviesClient = MovieClient.shared
        moviesNetworkDataSource = MovieNetworkDataSource.shared
        moviesUseCase = MoviesUseCase.shared
        moviesRepo = MoviesDataRepository.shared
        
        navigationController = UINavigationController()
    }
    
}

extension AppRouter: AppRouterProtocol {
    
    func showDetailScreen(for movieId: Int) {
        let vc = MovieDetailViewController(withMovieId: movieId)
                
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setInitialScreen(in window: UIWindow?) {
        let vc = HomePageViewController(
            presenter: HomePagePresenter(
                useCase: moviesUseCase,
                router: self
            )
        )
        
        navigationController.pushViewController(vc, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showTabBarView() {
        let tabBarController = createTabBarController()
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
}

extension AppRouter {
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let homePageVC = HomePageTwoViewController()
        let favouritesVC = FavouritesViewController()
        
        homePageVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: ImageEnum.homeTabBarItem.image,
            selectedImage: ImageEnum.homeTabBarItemSelected.image)
        
        favouritesVC.tabBarItem = UITabBarItem(
            title: "Favourites",
            image: ImageEnum.favouritesTabBarItem.image,
            selectedImage: ImageEnum.favouritesTabBarItemSelected.image)
        
        tabBarController.viewControllers = [homePageVC, favouritesVC]
        tabBarController.styleMovieTabBar()
        return tabBarController
    }
    
}
