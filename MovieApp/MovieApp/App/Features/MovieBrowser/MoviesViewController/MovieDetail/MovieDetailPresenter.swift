import Foundation
import UIKit

final class MovieDetailPresenter {
    
    private weak var delegate: MovieDetailDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
    
    let movieId: Int!
    
    init (useCase: MoviesUseCaseProtocol, router: AppRouter, for movieId: Int) {
        self.useCase = useCase
        self.router = router
        self.movieId = movieId
    }
    
    func setDelegate(delegate: MovieDetailDelegate) {
        self.delegate = delegate
    }
    
    func getMovieDetails() {
        useCase.getMovieDetails(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                self.delegate?.fillDetailTitleView(with: DetailTitleViewModel(fromModel: movie))
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getOverview() -> String {
        "One year after outwitting the FBI and winning the public’s adulation with their mind-bending spectacles, the Four Horsemen resurface only to find themselves face to face with a new enemy who enlists them to pull off their most dangerous heist yet."
    }
    
    func getCast() -> [CastViewModel] {
        let person = CastViewModel(name: "Edward Norton", characterName: "The Narrator", posterPath: URL(string: "https://image.tmdb.org/t/p/original/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg"))
        return Array(repeating: person, count: 6)
    }
    
    func getRecommendations() -> [MovieViewModel] {
        [MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg")),
         MovieViewModel(identifier: 1, title: "Bla bla", overview: "-", posterPath: URL(string: "https://image.tmdb.org/t/p/original/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"))]
    }
    
    func getReview() -> ReviewViewModel {
        ReviewViewModel(
            author: "The Peruvian Post",
            createdAt: "February 17, 2020",
            content: "When director Jon Favreau and Sarah Halley cast Robert Downey Jr, they glimpsed something magnificent: a more-than-skilled actor who faultlessly portrayed the role of Tony Stark. Despite Favreau's initial decision in choosing a fresh face, he ended up delighted due to his charismatic, natural and comfortable attitude. He did not realise it yet, but he was moulding with the right measures a whole superhero cinematic universe which lasted until today and still goes for more. The filmmakers took the proper time to introduce a character whose production was undecided since New Line Pictures argu... read the rest.",
            profileImagePath: URL(string: "https://secure.gravatar.com/avatar/3593437cbd05cebe0a4ee753965a8ad1.jpg"))
    }
    
}
