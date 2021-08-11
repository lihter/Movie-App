final class HomePageTwoPresenter {
    
    private weak var delegate: HomePageTwoDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
        
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func setDelegate(delegate: HomePageTwoDelegate) {
        self.delegate = delegate
    }
    
    func getAllCategories(addToTableView: Bool = true) {
        getPopularMovies(addToTableView: addToTableView)
        getTrendingMovies(addToTableView: addToTableView)
        getTopRatedMovies(addToTableView: addToTableView)
    }
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieViewModel] {
        let ucMovies = useCase.getMovies(for: category, genreId: genreId)
        return ucMovies.map { MovieViewModel(fromModel: $0) }
    }
    
    
    func showDetailScreen(for movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
    func getSubcategories(for category: LocalCategory) -> [Genre] {
        if category == .trending {
            return [.day, .week]
        }
        return [.action, .animation, .comedy, .scienceFiction, .thriller]
    }
    
    func getPopularMovies(addToTableView: Bool = true) {
        useCase.getPopularMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                if addToTableView {
                    self.delegate?.addToTableView(category: .popular)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrendingMovies(addToTableView: Bool = true) {
        useCase.getTrendingMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                if addToTableView {
                    self.delegate?.addToTableView(category: .trending)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopRatedMovies(addToTableView: Bool = true) {
        useCase.getTopRatedMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                if addToTableView {
                    self.delegate?.addToTableView(category: .topRated)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
    func toggleFavorite(_ movieId: Int) {
        useCase.toggleFavorite(movieId)
        
        delegate?.reloadData()
    }
    
}
