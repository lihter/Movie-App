import UIKit

class CrewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: NewMovieCell.self)
    static let height: CGFloat = 50
    
    let offset: CGFloat = 4
    
    var nameLabel: UILabel!
    var jobLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(with crewMember: CrewViewModel) {
        nameLabel.text = crewMember.name
        jobLabel.text = crewMember.job
    }
    
}
