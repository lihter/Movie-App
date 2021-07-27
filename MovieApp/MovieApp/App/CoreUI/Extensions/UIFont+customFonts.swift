import UIKit

extension UIFont {
    
    public static let tabBarFont: UIFont = .regular(size: 10)
    public static let searchBarFont: UIFont = .regular(size: 16)
    public static let heading1: UIFont = .bold(size: 20)
    public static let regularBold: UIFont = .bold()
    public static let regularSemiBold: UIFont = .semiBold()
    public static let regularMedium: UIFont = .regular()
    
    static func regular(size: CGFloat = 14) -> UIFont {
        UIFont(name: "ProximaNova-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(size: CGFloat = 16) -> UIFont {
        UIFont(name: "ProximaNova-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func semiBold(size: CGFloat = 16) -> UIFont {
        UIFont(name: "ProximaNova-Semibold", size: size) ?? .systemFont(ofSize: size)
    }
    
}
