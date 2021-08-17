import UIKit

class CrewStackView: UIView {
    
    var crew: [CrewViewModel]!
    
    var mainStackView: UIStackView!
    var stackRows: [UIStackView]!
    var crewViews: [CrewView]!
    
    init() {
        super.init(frame: .zero)
        
        stackRows = []
        crewViews = []
        
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(crew: [CrewViewModel]) {
        self.crew = crew
                
        setupCrewViews()
        
        styleViews()
        defineLayoutForViews()
    }
    
}
