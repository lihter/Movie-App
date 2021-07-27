import UIKit

enum ImageEnum {
    
    case navigationBarTitleImage
    case navigationBarBackButton

    case homeTabBarItem
    case homeTabBarItemSelected
    case favouritesTabBarItem
    case favouritesTabBarItemSelected
        
    var image: UIImage? {
        switch self {
        case .navigationBarBackButton:
            return UIImage(named: "BackButton.pdf")
        case .navigationBarTitleImage:
            return UIImage(named: "AppIcon.pdf")
        case .homeTabBarItem:
            return UIImage(named: "HomeButton2.pdf")
        case .homeTabBarItemSelected:
            return UIImage(named: "HomeButton.pdf")
        case .favouritesTabBarItem:
            return UIImage(named: "FavButton2.pdf")
        case .favouritesTabBarItemSelected:
            return UIImage(named: "FavButton.pdf")
        }
    }
    
}
