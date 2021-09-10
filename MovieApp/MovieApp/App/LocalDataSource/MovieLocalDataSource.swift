import Combine
import Foundation
import RealmSwift

class MovieLocalDataSource: MovieLocalDataSourceProtocol {

    static let shared: MovieLocalDataSourceProtocol = MovieLocalDataSource()

    func getMoviesPublisher(for category: CategoriesDataSource) -> AnyPublisher<[MovieDataModel], Never> {
        guard let realm = try? Realm() else { return .empty() }

        let movies = realm
            .objects(MovieRealmDataModel.self)
            .filter("category == %@", category.rawValue)
            .map { MovieDataModel(fromModel: $0) }

        return Just(Array(movies))
            .eraseToAnyPublisher()
    }

    func saveLocal(array: [MovieDataModel], category: CategoriesDataSource) {
        guard let realm = try? Realm() else { return }

        let mappedMovies = array
            .map { MovieRealmDataModel(fromModel: $0, category: category) }

        let oldMovies = realm
            .objects(MovieRealmDataModel.self)
            .filter("category == %@", category.rawValue)

        try? realm.write {
            realm.delete(oldMovies)
            realm.add(mappedMovies)
        }
    }

}
