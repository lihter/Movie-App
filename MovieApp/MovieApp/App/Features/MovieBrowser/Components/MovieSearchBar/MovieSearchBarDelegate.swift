protocol MovieSearchBarDelegate: AnyObject {
    
    func textDidChange(to text: String)
    
    func editingEnded()
    
    func editingStarted()
        
}
