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
    
    func fetchAll() {
        getMovieDetails()
        getOverview()
        getMostPopularCast()
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
    
    func getOverview() {
        useCase.getMovieOverview(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let overview):
                self.delegate?.fillOverview(with: overview)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
    }
    
    func getMostPopularCast() {
        useCase.getMostPopularCast(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let cast):
                let mappedCast = cast.map { CastViewModel(fromModel: $0) }
                self.delegate?.fillCastCV(with: mappedCast)
            case .failure(let error):
                print("Loading error: \(error.localizedDescription)")
            }
        }
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
