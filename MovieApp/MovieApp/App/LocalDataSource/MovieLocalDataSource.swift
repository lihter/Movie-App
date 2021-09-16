import Combine
import Foundation
import RealmSwift

class MovieLocalDataSource: MovieLocalDataSourceProtocol {

    func getMovies(for category: CategoriesDataSource) -> AnyPublisher<[MovieDataModel], Never> {
        guard let realm = try? Realm() else { return .empty() }

        let movies = realm
            .objects(MovieRealmDataModel.self)
            .filter("category == %@", category.rawValue)
            .map { MovieDataModel(fromModel: $0) }

        return Just(Array(movies))
            .eraseToAnyPublisher()
    }

    func save(movies: [MovieDataModel], category: CategoriesDataSource) {
        guard let realm = try? Realm() else { return }

        let mappedMovies = movies
            .map { MovieRealmDataModel(fromModel: $0, category: category) }

        let oldMovies = realm
            .objects(MovieRealmDataModel.self)
            .filter("category == %@", category.rawValue)

        try? realm.write {
            realm.delete(oldMovies)
            realm.add(mappedMovies, update: .all)
        }
    }

    func delete(movieId: Int, category: CategoriesDataSource) {
        guard let realm = try? Realm() else { return }

        let movie = realm
            .objects(MovieRealmDataModel.self)
            .filter("category == %@ AND identifier == %@", category.rawValue, movieId)

        try? realm.write {
            realm.delete(movie)
        }
    }

}
