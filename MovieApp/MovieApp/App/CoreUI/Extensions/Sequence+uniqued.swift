extension Sequence where Element: Hashable {
    
    var uniqued: [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    
}
