import Combine

protocol UserDefaultsDataSourceProtocol {

    var favorites: AnyPublisher<[Int], Never> { get }

    func toggleFavorite(_ movieId: Int)

}
