final class HomePageTwoPresenter {
    
    private weak var delegate: HomePageTwoDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    var categories: [CategoryViewModel]!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
        
        categories = []
    }
    
    func setDelegate(delegate: HomePageTwoDelegate) {
        self.delegate = delegate
    }
    
    func getAllCategories() {
        getPopularMovies()
        getTrendingMovies()
        getTopRatedMovies()
    }
    
    func getMovies(for subcategory: LocalSubcategory) -> [MovieViewModel] {
        var movies: [MovieViewModel] = []
        categories.forEach {
            if $0.subcategoryMovies.keys.contains(subcategory) {
                movies = $0.subcategoryMovies[subcategory] ?? []
            }
        }
        return movies
    }
    
    func getSubcategories(for category: LocalCategory) -> [LocalSubcategory] {
        guard
            let keys = categories.first(where: { $0.categoryKey == category })?.subcategoryMovies.keys
        else {
            return []
        }
        return Array(keys)
    }
    
    func getPopularMovies() {
        useCase.getPopularMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                guard let categoryVM = self.popularMoviesToCategory(movies) else { return }
                self.categories.append(categoryVM)
                self.delegate?.addToTableView(category: categoryVM.categoryKey)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrendingMovies() {
        var dayMovies: [MovieModel] = []
        var weekMovies: [MovieModel] = []
        
        useCase.getTrendingMoviesToday { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                dayMovies = movies
                if !weekMovies.isEmpty, !dayMovies.isEmpty {
                    guard let categoryVM = self.trendingMoviesToCategory(dayMovies: dayMovies, weekMovies: weekMovies) else { return }
                    self.categories.append(categoryVM)
                    self.delegate?.addToTableView(category: categoryVM.categoryKey)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
        
        useCase.getTrendingMoviesThisWeek { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                weekMovies = movies
                if !weekMovies.isEmpty, !dayMovies.isEmpty {
                    guard let categoryVM = self.trendingMoviesToCategory(dayMovies: dayMovies, weekMovies: weekMovies) else { return }
                    self.categories.append(categoryVM)
                    self.delegate?.addToTableView(category: categoryVM.categoryKey)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopRatedMovies() {
        var moviesTopRated: [MovieModel] = []
        var tvTopRated: [MovieModel] = []
        
        useCase.getTopRatedMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                moviesTopRated = result
                if !moviesTopRated.isEmpty, !tvTopRated.isEmpty {
                    guard let categoryVM = self.topRatedMoviesToCategory(tvShows: tvTopRated, movies: moviesTopRated) else { return }
                    self.categories.append(categoryVM)
                    self.delegate?.addToTableView(category: categoryVM.categoryKey)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
        
        useCase.getTopRatedTV { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                tvTopRated = result
                if !moviesTopRated.isEmpty, !tvTopRated.isEmpty {
                    guard let categoryVM = self.topRatedMoviesToCategory(tvShows: tvTopRated, movies: moviesTopRated) else { return }
                    self.categories.append(categoryVM)
                    self.delegate?.addToTableView(category: categoryVM.categoryKey)
                }
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedMovie(withId movieId: Int) {
        router.showDetailScreen(for: movieId)
    }
    
}

//MARK: - Filtering functions

extension HomePageTwoPresenter {
    
    private func topRatedMoviesToCategory(tvShows: [MovieModel]?, movies: [MovieModel]?) -> CategoryViewModel? {
        guard
            let tvShows = tvShows,
            let movies = movies
        else {
            return nil
        }
        
        let moviesVM = movies.map { MovieViewModel(fromModel: $0) }
        let tvShowsVM = tvShows.map { MovieViewModel(fromModel: $0) }
        
        var dictionary = emptyDictionary(for: .topRated)
        
        dictionary[.topRatedTV] = tvShowsVM
        dictionary[.topRatedMovies] = moviesVM
        
        let category = CategoryViewModel(
            categoryKey: .topRated,
            subcategoryMovies: dictionary)
        return category
    }
    
    private func trendingMoviesToCategory(dayMovies: [MovieModel]?, weekMovies: [MovieModel]?) -> CategoryViewModel? {
        guard
            let dayMovies = dayMovies,
            let weekMovies = weekMovies
        else {
            return nil
        }
        
        let dayMoviesVM = dayMovies.map { MovieViewModel(fromModel: $0) }
        let weekMoviesVM = weekMovies.map { MovieViewModel(fromModel: $0) }
        
        var dictionary = emptyDictionary(for: .trending)
                
        dictionary[.trendingToday] = dayMoviesVM
        dictionary[.trendingThisWeek] = weekMoviesVM
        
        let category = CategoryViewModel(
            categoryKey: .trending,
            subcategoryMovies: dictionary)
        return category
    }
    
    private func popularMoviesToCategory(_ movies: [MovieModel]?) -> CategoryViewModel? {
        guard let movies = movies else { return nil }
        
        let moviesVM = movies.map { MovieViewModel(fromModel: $0) }
        
        var dictionary = emptyDictionary(for: .popular)
        
        for movieVM in moviesVM {
            let firstLetter = movieVM.title.prefix(1).lowercased()
            switch firstLetter {
            case _ where firstLetter <= "d":
                dictionary[.popularStreaming]?.append(movieVM)
            case _ where firstLetter <= "l":
                dictionary[.popularOnTV]?.append(movieVM)
            case _ where firstLetter <= "p":
                dictionary[.popularForRent]?.append(movieVM)
            case _ where firstLetter <= "t":
                dictionary[.popularFreeToWatch]?.append(movieVM)
            default:
                dictionary[.popularInTheaters]?.append(movieVM)
            }
        }
        
        let category = CategoryViewModel(
            categoryKey: .popular,
            subcategoryMovies: dictionary)
        return category
    }
    
    private func emptyDictionary(for category: LocalCategory) -> [LocalSubcategory: [MovieViewModel]] {
        var dictionary: [LocalSubcategory: [MovieViewModel]] = [:]
        
        for subcategory in category.subcategories {
            dictionary[subcategory] = []
        }
        
        return dictionary
    }
    
}
