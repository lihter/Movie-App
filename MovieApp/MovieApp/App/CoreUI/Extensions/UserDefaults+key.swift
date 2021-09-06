import Foundation

extension UserDefaults {

    @objc dynamic var favorites: [Int] {
        array(forKey: "favorites") as? [Int] ?? []
    }

}
