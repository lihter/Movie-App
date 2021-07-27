protocol HomePageDelegate: AnyObject {
    
    func reloadCollectionView(with movies: [MovieViewModel]?)
    
}
