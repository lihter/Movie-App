import UIKit
import SnapKit

extension SearchViewController: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        tableView.rowHeight = 154
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }
    
    func defineLayoutForViews() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
        
}
