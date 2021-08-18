import UIKit

class GenreButton: UIView {
    
    var title: String!
    
    var button: UIButton!
    var underline: UIView!
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.title = title
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
    
}
