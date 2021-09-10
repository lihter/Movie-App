import Combine

extension Publisher where Output == [MovieDataModel], Failure == RequestError {

    func handleLocalStorage(localDataSource: MovieLocalDataSourceProtocol) -> AnyPublisher<[MovieDataModel], Never> {
        handleEvents(receiveOutput: {
            localDataSource.saveLocal(array: $0, category: .topRated)
        })
        .replaceError(with: [])
        .flatMap { _ -> AnyPublisher<[MovieDataModel], Never> in
            localDataSource.getMoviesPublisher(for: .topRated)
        }
        .eraseToAnyPublisher()
    }

}
