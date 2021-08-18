final class SearchPresenter {
    
    private weak var delegate: SearchDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
        
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func setDelegate(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    func getSearchedMovies(searchQuery: String) {
        useCase.getSearchedMovies(searchQuery: searchQuery) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                let mappedMovies = movies.map { MovieViewModel(fromModel: $0) }
                self.delegate?.showSearchedMovies(mappedMovies)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
}
