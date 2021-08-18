import Foundation

struct DetailTitleViewModel {
    
    let title: String
    let year: String
    let releaseDate: String
    let genres: [String]
    let duration: String
    let userScore: Int
    let posterPath: URL?
    let isFavorite: Bool
    
}

extension DetailTitleViewModel {
    
    init(fromModel model: MovieModel) {
        var dateString = ""
        var year = ""
        
        if let date = model.releaseDate, !date.isEmpty {
            let dateSplitted = date.split(separator: "-")
            dateString = "\(dateSplitted[1])/\(dateSplitted[2])/\(dateSplitted[0])"
            year = String(dateSplitted[0])
        }
        
        let hours = (model.runtime ?? 0) / 60
        let minutes = (model.runtime ?? 0) % 60
        
        self.init(
            title: model.title,
            year: year,
            releaseDate: dateString,
            genres: model.genreIds!.map { Genre(rawValue: $0)?.genreName ?? "" },
            duration: "\(hours)h \(minutes)m",
            userScore: Int(model.voteAverage * 10),
            posterPath: model.posterPath,
            isFavorite: model.isFavorite)
    }
    
}
