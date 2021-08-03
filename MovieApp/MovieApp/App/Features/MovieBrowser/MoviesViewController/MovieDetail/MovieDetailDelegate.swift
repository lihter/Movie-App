protocol MovieDetailDelegate: AnyObject {
    
    func fillDetailTitleView(with movieDetails: DetailTitleViewModel)
    
    func fillOverview(with overview: String)
    
}
