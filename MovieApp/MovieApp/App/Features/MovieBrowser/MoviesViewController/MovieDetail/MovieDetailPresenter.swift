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
    
    func getReview(for movieId: Int) -> ReviewViewModel {
        ReviewViewModel(
          author: "The Peruvian Post",
          createdAt: "February 17, 2020",
          content: "When director Jon Favreau and Sarah Halley cast Robert Downey Jr, they glimpsed something magnificent: a more-than-skilled actor who faultlessly portrayed the role of Tony Stark. Despite Favreau's initial decision in choosing a fresh face, he ended up delighted due to his charismatic, natural and comfortable attitude. He did not realise it yet, but he was moulding with the right measures a whole superhero cinematic universe which lasted until today and still goes for more. The filmmakers took the proper time to introduce a character whose production was undecided since New Line Pictures argu... read the rest.",
          profileImagePath: URL(string: "https://secure.gravatar.com/avatar/3593437cbd05cebe0a4ee753965a8ad1.jpg"))
    }
    
}
