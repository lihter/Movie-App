struct CategoryViewModel {
    
    let categoryKey: LocalCategory
    /*let subcategories: [LocalSubcategory]
    let movies: [MovieViewModel]*/
    let subcategoryMovies: [LocalSubcategory: [MovieViewModel]]
    
}
