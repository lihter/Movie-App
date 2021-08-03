enum Genre: Int {
    
    case action = 28
    case adventure = 12
    case comedy = 35
    case drama = 18
    case family = 10751
    case horror = 27
    case romance = 10749
    case thriller = 53
    case scienceFiction = 878
    case animation = 16
    case crime = 80
    case documentary = 99
    case fantasy = 14
    case history = 36
    case music = 10402
    case tvMovie = 10770
    case war = 10752
    case western = 37
    case actionAdventure = 10759
    case kids = 10762
    case mystery = 9648
    case news = 10763
    case reality = 10764
    case sciFiFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warPolitics = 10768
    
    var genreName: String {
        switch self {
        case .sciFiFantasy:
            return "Sci-Fi & Fantasy"
        case .soap:
            return "Soap"
        case .talk:
            return "Talk"
        case .warPolitics:
            return "War & Politics"
        case .action:
            return "Action"
        case .adventure:
            return "Adventure"
        case .comedy:
            return "Comedy"
        case .drama:
            return "Drama"
        case .family:
            return "Family"
        case .horror:
            return "Horror"
        case .romance:
            return "Romance"
        case .thriller:
            return "Thriller"
        case .scienceFiction:
            return "Science Fiction"
        case .animation:
            return "Animation"
        case .crime:
            return "Crime"
        case .documentary:
            return "Documentary"
        case .fantasy:
            return "Fantasy"
        case .history:
            return "History"
        case .music:
            return "Music"
        case .tvMovie:
            return "TV Movie"
        case .war:
            return "War"
        case .western:
            return "Western"
        case .actionAdventure:
            return "Action & Adventure"
        case .kids:
            return "Kids"
        case .mystery:
            return "Mystery"
        case .news:
            return "News"
        case .reality:
            return "Reality"
        }
    }
    
}
