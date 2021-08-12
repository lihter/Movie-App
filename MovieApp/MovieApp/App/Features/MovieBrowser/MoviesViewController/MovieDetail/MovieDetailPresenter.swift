import Foundation
import UIKit

final class MovieDetailPresenter {
    
    func getMovieDetails(for movieId: Int) -> DetailTitleViewModel {
        DetailTitleViewModel(
            title: "Iron Man",
            year: "2008",
            releaseDate: "05/02/2008",
            genres: ["Action, Sci Fi, Adventure"],
            duration: "2h 6m",
            userScore: 76,
            posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"))
    }
    
    func getOverview(for movieId: Int) -> String {
        "One year after outwitting the FBI and winning the public’s adulation with their mind-bending spectacles, the Four Horsemen resurface only to find themselves face to face with a new enemy who enlists them to pull off their most dangerous heist yet."
    }
    
    func getRecommendations(for movieId: Int) -> [MovieViewModel] {
        [MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"))]
    }
    
    func getCast(for movieId: Int) -> [CastViewModel] {
        let person = CastViewModel(name: "Edward Norton", characterName: "The Narrator", posterPath: URL(string: "https://image.tmdb.org/t/p/original/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg"))
        return Array(repeating: person, count: 6)
    }
    
}
