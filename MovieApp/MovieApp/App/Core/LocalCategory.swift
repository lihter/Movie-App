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
    
}
