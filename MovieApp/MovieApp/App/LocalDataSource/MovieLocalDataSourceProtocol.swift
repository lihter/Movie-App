import Combine

protocol MovieLocalDataSourceProtocol {

    func getMovies(for category: CategoriesDataSource) ->  AnyPublisher<[MovieDataModel], Never>

    func save(movies: [MovieDataModel], category: CategoriesDataSource)

    func delete(movieId: Int, category: CategoriesDataSource)

}
