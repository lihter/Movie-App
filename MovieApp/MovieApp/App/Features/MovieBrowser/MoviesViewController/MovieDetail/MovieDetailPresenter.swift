import Foundation
import UIKit

final class MovieDetailPresenter {
    
    func getMovieDetails(for movieId: Int) -> DetailTitleViewModel { }
    
    func getOverview(for movieId: Int) -> String { }
    
    func getCast(for movieId: Int) -> [CastViewModel] { }
    
    func getRecommendations(for movieId: Int) -> [MovieViewModel] { }
    
    func getReview(for movieId: Int) -> ReviewViewModel { }
    
}
