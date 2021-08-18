protocol HomePageTwoDelegate: AnyObject {
    
    func addToTableView(category: LocalCategory?)
    
    func reloadData()
    
    func showSearchedMovies(_ movies: [MovieViewModel])
    
}
