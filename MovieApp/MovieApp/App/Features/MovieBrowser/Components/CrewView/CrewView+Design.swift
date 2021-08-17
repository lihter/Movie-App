import UIKit

extension CrewView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        nameLabel = UILabel()
        addSubview(nameLabel)
        
        jobLabel = UILabel()
        addSubview(jobLabel)
    }
    
    func styleViews() {
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.font = .smallBold
        
        jobLabel.textColor = .secondaryGray
        jobLabel.numberOfLines = 0
        jobLabel.lineBreakMode = .byWordWrapping
        jobLabel.font = .regularMedium
    }
    
    func defineLayoutForViews() {
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        jobLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(offset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
