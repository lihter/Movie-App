enum LocalSubcategory: Int {
    
    case popularStreaming = 1
    case popularOnTV
    case popularForRent
    case popularInTheaters
    
    case freeMovies
    case freeTv
    
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
        case .freeMovies:
            return "Movies"
        case .freeTv:
            return "TV"
        case .trendingToday:
            return "Today"
        case .trendingThisWeek:
            return "This week"
        }
    }
    
}
