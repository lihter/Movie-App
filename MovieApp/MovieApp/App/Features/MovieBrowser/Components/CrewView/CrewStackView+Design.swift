import UIKit

extension CrewStackView: DesignProtocol {
    
    func createViews() {
        mainStackView = UIStackView()
        addSubview(mainStackView)
    }
    
    func styleViews() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 24
        for stackView in stackRows {
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = 4
        }
    }
    
    func defineLayoutForViews() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        for stackView in stackRows {
            stackView.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }
    }
    
}

extension CrewStackView {
    
    func setupCrewViews() {
        let rowCount = ceil(Double(crew.count) / 3.0) >= 2.0 ? 2 : crew.count / 3 + 1
        let elementCount = crew.count < 6 ? crew.count : 6
        
        for _ in 0..<rowCount {
            let row = UIStackView()
            
            mainStackView.addArrangedSubview(row)
            stackRows.append(row)
        }
        
        for i in 0..<elementCount {
            let row = i / 3
            let crewView = CrewView()
            let stack = stackRows[row]
            let crewMember = crew[i]
            
            crewView.populate(name: crewMember.name, job: crewMember.job)
            crewViews.append(crewView)
            stack.addArrangedSubview(crewView)
        }
    }
    
}
