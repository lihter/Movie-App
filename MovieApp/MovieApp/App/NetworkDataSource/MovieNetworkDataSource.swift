class MovieNetworkDataSource: MovieNetworkDataSourceProtocol {
    
    static let shared: MovieNetworkDataSourceProtocol = MovieNetworkDataSource()
    
    private let movieClient: MovieClientProtocol!
    
    init() {
        self.movieClient = MovieClient.shared
    }

    func fetchPopularMovies(completion: @escaping (Result<[MovieNetworkDataSourceModel]?, RequestError>) -> Void) {
        movieClient.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                let mappedMovies = self.mapMovies(movies)
                completion(.success(mappedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

extension MovieNetworkDataSource {
    
    private func mapMovies(_ movies: [MovieNetworkModel]?) -> [MovieNetworkDataSourceModel]?{
        return movies?.map {
            return MovieNetworkDataSourceModel(
                identifier: $0.identifier,
                title: $0.title,
                backdropPath: $0.backdropPath,
                posterPath: $0.posterPath,
                overview: $0.overview,
                voteAverage: $0.voteAverage,
                voteCount: $0.voteCount,
                releaseDate: $0.releaseDate,
                genreIds: $0.genreIds,
                budget: $0.budget)
        }
    }
    
}
