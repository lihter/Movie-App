import Combine

protocol MovieLocalDataSourceProtocol {

    func flatMap(
        _ publisher: AnyPublisher<[MovieDataModel], MovieDataError>,
        category: CategoriesDataSource
    ) -> AnyPublisher<[MovieDataModel], Never>

    func getMoviesArray(for category: CategoriesDataSource) ->  AnyPublisher<[MovieDataModel], Never>

    func save(array: [MovieDataModel], category: CategoriesDataSource)

    func delete(movieId: Int, category: CategoriesDataSource)

}
