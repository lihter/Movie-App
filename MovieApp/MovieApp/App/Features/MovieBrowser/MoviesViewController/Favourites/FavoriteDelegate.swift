protocol FavoriteDelegate: AnyObject {
    
    func showMovies(_ movies: [MovieViewModel])
    
    func reloadData()
    
}
