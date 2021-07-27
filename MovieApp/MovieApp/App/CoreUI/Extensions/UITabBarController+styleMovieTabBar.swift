import UIKit

extension UITabBarController {
    
    func styleMovieTabBar() {
        self.tabBar.isTranslucent = false
        UITabBar.appearance().tintColor = .tabbarTintItemColor
        UITabBarItem.appearance().setTitleTextAttributes(
            [.font: UIFont.tabBarFont],
            for: .normal)
    }
    
}
