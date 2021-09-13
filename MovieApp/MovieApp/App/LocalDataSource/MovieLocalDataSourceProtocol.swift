import Combine

protocol MovieLocalDataSourceProtocol {

    func getMoviesPublisher(for category: CategoriesDataSource) ->  AnyPublisher<[MovieDataModel], Never>

    func saveLocal(array: [MovieDataModel], category: CategoriesDataSource)

    func saveLocal(movie: MovieDataModel, category: CategoriesDataSource)

    func deleteLocal(movieId: Int, category: CategoriesDataSource)

}
