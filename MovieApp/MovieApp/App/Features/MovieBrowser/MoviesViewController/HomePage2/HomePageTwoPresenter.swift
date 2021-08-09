final class HomePageTwoPresenter {
    
    private weak var delegate: HomePageTwoDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    var categories: [LocalCategory: [MovieViewModel]]!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
        
        categories = [:]
    }
    
    func setDelegate(delegate: HomePageTwoDelegate) {
        self.delegate = delegate
    }
    
    func getAllCategories() {
        getPopularMovies()
        getTrendingMovies()
        getTopRatedMovies()
    }
    
    func getMovies(for category: LocalCategory, genreId: Int) -> [MovieViewModel] {
        var movies: [MovieViewModel]
        movies = categories[category]?.filter{
            $0.genreIds?.contains(genreId) ?? false
        } ?? []
        return movies
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
    
    func getPopularMovies() {
        useCase.getPopularMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.categories[.popular] = movies.map { MovieViewModel(fromModel: $0) }
                self.delegate?.addToTableView(category: .popular)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrendingMovies() {
        var dayMovies: Bool = false
        var weekMovies: Bool = false
        
        categories[.trending] = []
        
        useCase.getTrendingMoviesToday { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                dayMovies = true
                self.categories[.trending]?
                    .append(contentsOf: movies.map { MovieViewModel(fromModel: $0, withGenre: Genre.day.rawValue) } )
                if weekMovies, dayMovies {
                    self.delegate?.addToTableView(category: .trending)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
        
        useCase.getTrendingMoviesThisWeek { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                weekMovies = true
                self.categories[.trending]?
                    .append(contentsOf: movies.map { MovieViewModel(fromModel: $0, withGenre: Genre.week.rawValue) } )
                if weekMovies, dayMovies {
                    self.delegate?.addToTableView(category: .trending)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopRatedMovies() {
        useCase.getTopRatedMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.categories[.topRated] = movies.map { MovieViewModel(fromModel: $0) }
                self.delegate?.addToTableView(category: .topRated)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
}
