import UIKit

extension UITabBarController {
    
    func styleMovieTabBar() {
        self.tabBar.isTranslucent = false
        UITabBar.appearance().tintColor = .tabbarTintItemColor
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: Fonts.proximaMedium, size: 10)!],
            for: .normal)
    }
    
}
