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
        let vc = MovieDetailViewController(withMovieId: movieId)
                
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
        let homePageVC = HomePageTwoViewController()
        let favouritesVC = FavouritesViewController()
        
        homePageVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(with: .homeTabBarItem),
            selectedImage: UIImage(with: .homeTabBarItemSelected))
        
        favouritesVC.tabBarItem = UITabBarItem(
            title: "Favourites",
            image: UIImage(with: .favouritesTabBarItem),
            selectedImage: UIImage(with: .favouritesTabBarItemSelected))
        
        tabBarController.viewControllers = [homePageVC, favouritesVC]
        tabBarController.styleMovieTabBar()
        tabBarController.navigationItem.titleView = UIImageView(image: UIImage(with: .navigationBarTitleImage))
        return tabBarController
    }
    
    private func styleNavigationBar() {
        navigationController?.navigationBar.barTintColor = .primaryBlue
        navigationController?.navigationBar.backIndicatorImage = UIImage(with: .navigationBarBackButton)
        navigationController?.navigationBar.isTranslucent = false
    }
    
}
