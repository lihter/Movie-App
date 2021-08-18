import UIKit

class CrewView: UIView {
    
    let offset: CGFloat = 4
    
    var nameLabel: UILabel!
    var jobLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(name: String, job: String) {
        nameLabel.text = name
        jobLabel.text = job
    }
    
}
