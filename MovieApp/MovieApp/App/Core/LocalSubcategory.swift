enum LocalSubcategory: Int {
    
    case popularStreaming = 1
    case popularOnTV
    case popularForRent
    case popularInTheaters
    case popularFreeToWatch
    
    case topRatedTV
    case topRatedMovies
    
    case trendingToday
    case trendingThisWeek
    
    var description: String {
        switch self {
        case .popularStreaming:
            return "Streaming"
        case .popularOnTV:
            return "On TV"
        case .popularForRent:
            return "For rent"
        case .popularInTheaters:
            return "In theaters"
        case .popularFreeToWatch:
            return "Free to watch"
        case .topRatedMovies:
            return "Movies"
        case .topRatedTV:
            return "TV"
        case .trendingToday:
            return "Today"
        case .trendingThisWeek:
            return "This week"
        }
    }
    
}
