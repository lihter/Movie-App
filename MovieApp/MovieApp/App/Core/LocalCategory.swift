enum LocalCategory {
    
    case popular
    case trending
    case topRated
    
    var title: String {
        switch self {
        case .popular:
            return "What's popular"
        case .trending:
            return "Trending"
        case .topRated:
            return "Top Rated"
        }
    }
    
    var subcategories: [LocalSubcategory] {
        switch self {
        case .popular:
            return [.popularStreaming, .popularFreeToWatch, .popularOnTV, .popularForRent, .popularInTheaters]
        case .topRated:
            return [.topRatedTV, .topRatedMovies]
        case .trending:
            return [.trendingToday, .trendingThisWeek]
        }
    }
    
}
