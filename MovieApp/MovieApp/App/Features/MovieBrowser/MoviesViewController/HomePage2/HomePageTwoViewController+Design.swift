import UIKit
import SnapKit

extension HomePageTwoViewController: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        searchBar = MovieSearchBar()
        view.addSubview(searchBar)
        
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        tableView.rowHeight = CategoryCell.height + tableRowOffset
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }
    
    func defineLayoutForViews() {
        searchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5 * offset)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(2 * offset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
        
}
