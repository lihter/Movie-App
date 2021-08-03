import Foundation

struct DetailTitleViewModel {
    
    let title: String
    let year: String
    let releaseDate: String
    let genres: [String]
    let duration: String
    let userScore: Int
    let posterPath: URL?
    
}

extension DetailTitleViewModel {
    
    init(fromModel model: MovieModel) {
        self.init(
            title: model.title,
            year: String(model.releaseDate?.split(separator: "-")[0] ?? ""),
            releaseDate: "\(String(model.releaseDate?.split(separator: "-")[1] ?? ""))/\(String(model.releaseDate?.split(separator: "-")[2] ?? ""))/ \(String(model.releaseDate?.split(separator: "-")[0] ?? ""))",
            genres: model.genreIds!.map { Genre(rawValue: $0)?.genreName ?? "" },
            duration: "\((model.runtime ?? 0) / 60)h \((model.runtime ?? 0) % 60)m",
            userScore: Int(model.voteAverage * 10),
            posterPath: model.posterPath)
        
    }
    
}
