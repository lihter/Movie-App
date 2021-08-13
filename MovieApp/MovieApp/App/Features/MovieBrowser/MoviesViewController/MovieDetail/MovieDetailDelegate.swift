protocol MovieDetailDelegate: AnyObject {
    
    func fillDetailTitleView(with movieDetails: DetailTitleViewModel)
    
    func fillOverview(with overview: String)
    
    func fillCastCV(with cast: [CastViewModel])
    
    func fillRecommendationsCV(with movies: [MovieViewModel])
    
    func fillReview(with review: ReviewViewModel)
    
    func reloadData()
    
}
