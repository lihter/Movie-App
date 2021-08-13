import UIKit

final class AppRouter {
    
    private let networkClient: NetworkClientProtocol!
    private let moviesClient: MovieClientProtocol!
    private let moviesNetworkDataSource: MovieNetworkDataSourceProtocol!
    private let moviesRepo: MovieRepositoryProtocol!
    private let moviesUseCase: MoviesUseCaseProtocol!
    
    private let navigationController: UINavigationController!
    
    init() {
        networkClient = NetworkClient.shared
        moviesClient = MovieClient.shared
        moviesNetworkDataSource = MovieNetworkDataSource.shared
        moviesUseCase = MoviesUseCase.shared
        moviesRepo = MovieRepository.shared
        
        navigationController = UINavigationController()
        styleNavigationBar()
    }
    
    func showDetailScreen(for movieId: Int) {
        let movieDetailPresenter = MovieDetailPresenter(useCase: moviesUseCase, router: self, for: movieId)
        let vc = MovieDetailViewController(presenter: movieDetailPresenter)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setInitialScreen(in window: UIWindow?) {
        let vc = createTabBarController()
        
        navigationController.setViewControllers([vc], animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}

extension AppRouter {
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let homePagePresenter = HomePageTwoPresenter(useCase: moviesUseCase, router: self)
        let homePageVC = HomePageTwoViewController(presenter: homePagePresenter)
        let favoritesPresenter = FavoritesPresenter(router: self)
        let favoritesVC = FavoritesViewController(presenter: favoritesPresenter)
        
        homePageVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(with: .homeTabBarItem),
            selectedImage: UIImage(with: .homeTabBarItemSelected))
        
        favoritesVC.tabBarItem = UITabBarItem(
            title: "Favourites",
            image: UIImage(with: .favouritesTabBarItem),
            selectedImage: UIImage(with: .favouritesTabBarItemSelected))
        
        tabBarController.viewControllers = [homePageVC, favoritesVC]
        tabBarController.styleMovieTabBar()
        tabBarController.navigationItem.titleView = UIImageView(image: UIImage(with: .navigationBarTitleImage))
        return tabBarController
    }
    
    private func styleNavigationBar() {
        navigationController.navigationBar.barTintColor = .primaryBlue
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = .white
    }
    
}
