protocol UserDefaultsDataSourceProtocol {
    
    var favorites: [Int] { get }
    
    func toggleFavorite(_ movieId: Int)
    
    func isFavorite(movieId: Int) -> Bool 
    
}
