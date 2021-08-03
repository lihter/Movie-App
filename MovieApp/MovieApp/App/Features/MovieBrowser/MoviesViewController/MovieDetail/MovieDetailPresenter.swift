import Foundation
import UIKit

final class MovieDetailPresenter {
    
    private weak var delegate: MovieDetailDelegate?
    private let useCase: MoviesUseCaseProtocol!
    private let router: AppRouter!
        
    init (useCase: MoviesUseCaseProtocol, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func setDelegate(delegate: MovieDetailDelegate) {
        self.delegate = delegate
    }
    
    func fetchAll(for movieId: Int) {
        getMovieDetails(for: movieId)
        getOverview(for: movieId)
    }
    
    func getMovieDetails(for movieId: Int) {
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
    
    func getOverview(for movieId: Int) {
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
    
    func getCast(for movieId: Int) -> [CastViewModel] {
        [CastViewModel(name: "Emily Blunt", characterName: "Bla bla", posterPath: URL(string: "https://image.tmdb.org/t/p/original/jqlqq3knztTnty5rcMg5evqZRCa.jpg")),
        CastViewModel(name: "Tae Joo", characterName: "Hoo haa", posterPath: URL(string: "https://image.tmdb.org/t/p/original/nGpa3za6yxSciko2J8tY8gbsgyT.jpg")),
        CastViewModel(name: "Vin Diesel", characterName: "Family boi", posterPath: URL(string: "https://image.tmdb.org/t/p/original/7rwSXluNWZAluYMOEWBxkPmckES.jpg")),
        CastViewModel(name: "Dwayne Johnson", characterName: "The Kamen", posterPath: URL(string: "https://image.tmdb.org/t/p/original/cgoy7t5Ve075naBPcewZrc08qGw.jpg")),
        CastViewModel(name: "Emily Blunt", characterName: "Bla bla", posterPath: URL(string: "https://image.tmdb.org/t/p/original/jqlqq3knztTnty5rcMg5evqZRCa.jpg")),
        CastViewModel(name: "Tae Joo", characterName: "Hoo haa", posterPath: URL(string: "https://image.tmdb.org/t/p/original/nGpa3za6yxSciko2J8tY8gbsgyT.jpg")),
        CastViewModel(name: "Vin Diesel", characterName: "Family boi", posterPath: URL(string: "https://image.tmdb.org/t/p/original/7rwSXluNWZAluYMOEWBxkPmckES.jpg")),
        CastViewModel(name: "Dwayne Johnson", characterName: "The Kamen", posterPath: URL(string: "https://image.tmdb.org/t/p/original/cgoy7t5Ve075naBPcewZrc08qGw.jpg"))]
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
    
    func getReview(for movieId: Int) -> ReviewViewModel {
        ReviewViewModel(
            author: "The Peruvian Post",
            createdAt: "February 17, 2020",
            content: "When director Jon Favreau and Sarah Halley cast Robert Downey Jr, they glimpsed something magnificent: a more-than-skilled actor who faultlessly portrayed the role of Tony Stark. Despite Favreau's initial decision in choosing a fresh face, he ended up delighted due to his charismatic, natural and comfortable attitude. He did not realise it yet, but he was moulding with the right measures a whole superhero cinematic universe which lasted until today and still goes for more. The filmmakers took the proper time to introduce a character whose production was undecided since New Line Pictures argu... read the rest.",
            profileImagePath: URL(string: "https://secure.gravatar.com/avatar/3593437cbd05cebe0a4ee753965a8ad1.jpg"))
    }
    
}
