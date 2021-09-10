import Combine

protocol MovieLocalDataSourceProtocol {

    func getMoviesPublisher(for category: CategoriesDataSource) ->  AnyPublisher<[MovieDataModel], Never>

    func saveLocal(array: [MovieDataModel], category: CategoriesDataSource)

}
