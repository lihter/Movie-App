protocol CategoriesDelegate: AnyObject {
    
    func addToTableView(category: LocalCategory?)
    
    func reloadData()
        
}
