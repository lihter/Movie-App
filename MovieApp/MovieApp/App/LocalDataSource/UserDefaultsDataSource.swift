import Combine
import Foundation

class UserDefaultsDataSource: UserDefaultsDataSourceProtocol {
    
    static let shared: UserDefaultsDataSource = UserDefaultsDataSource()
    
    private let favoritesUDKey = "favorites"
    
//    var favorites: [Int] {
//        if let favorites = UserDefaults.standard.object(forKey: favoritesUDKey) as? [Int] {
//            return favorites
//        } else {
//            return []
//        }
//    }
    
    var favorites: AnyPublisher<[Int], Never> {
        UserDefaults
            .standard
            .publisher(for: \.favorites)
            .receiveOnBackground()
    }
    
    func toggleFavorite(_ movieId: Int) {
        guard var favorites = UserDefaults.standard.object(forKey: favoritesUDKey) as? [Int] else {
            UserDefaults.standard.setValue([movieId], forKey: favoritesUDKey)
            return
        }
        
        if favorites.contains(movieId) {
            favorites.removeAll { $0 == movieId }
        } else {
            favorites.append(movieId)
        }
        UserDefaults.standard.setValue(favorites, forKey: favoritesUDKey)
    }
    
//    func isFavorite(movieId: Int) -> Bool {
//        favorites.contains(movieId)
//    }
    
}
