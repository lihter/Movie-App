import UIKit
import Resolver

final class AppRouter {

    let container: Resolver!

    private let navigationController: UINavigationController!

    init(container: Resolver) {
        self.container = container
        navigationController = UINavigationController()
        styleNavigationBar()
    }

    func showDetailScreen(for movieId: Int) {
        let vc: MovieDetailViewController = container.resolve()
        vc.presenter.setMovieId(movieId)

        navigationController?.pushViewController(vc, animated: true)
    }

    func start(in window: UIWindow?) {
        let vc = createTabBarController()

        navigationController.setViewControllers([vc], animated: true)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

extension AppRouter {

    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let homePageVC: HomePageViewController = container.resolve()
        let favoritesVC: FavoritesViewController = container.resolve()

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
