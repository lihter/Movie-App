import Foundation
import Kingfisher
import RealmSwift

final class MovieRealmDataModel: Object, ObjectKeyIdentifiable {

    @Persisted var identifier: Int
    @Persisted var title: String
    @Persisted var backdropPath: String
    @Persisted var posterPath: String
    @Persisted var overview: String
    @Persisted var voteAverage: Double
    @Persisted var voteCount: Double
    @Persisted var releaseDate: String
    @Persisted var genreIds = List<Int>()
    @Persisted var budget: Int
    @Persisted var runtime: Int
    @Persisted var category: Int

}

extension MovieRealmDataModel {

    convenience init(fromModel model: MovieDataModel, category: CategoriesDataSource) {
        self.init()

        self.identifier = model.identifier
        self.title = model.title
        self.backdropPath = model.backdropPath ?? ""
        self.posterPath = model.posterPath
        self.overview = model.overview
        self.voteAverage = model.voteAverage
        self.voteCount = model.voteCount
        self.releaseDate = model.releaseDate ?? ""
        self.genreIds.append(objectsIn: model.genreIds ?? [])
        self.budget = model.budget ?? 0
        self.runtime = model.runtime ?? 0
        self.category = category.rawValue
    }

}
