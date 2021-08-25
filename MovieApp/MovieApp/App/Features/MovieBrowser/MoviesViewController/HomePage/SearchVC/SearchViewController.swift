import Combine
import UIKit

class SearchViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<SearchSection, MovieViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchSection, MovieViewModel>
    
    let offset: CGFloat = 4
        
    var tableView: UITableView!
    var presenter: SearchPresenter!
    var dataSource: DataSource!
    
    private var disposables = Set<AnyCancellable>()
    
    init(presenter: SearchPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupTableView()
        makeDataSource()
    }
    
    private func setupTableView() {
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func makeDataSource() {
        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, movie) -> UITableViewCell? in
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: MovieCell.reuseIdentifier,
                        for: indexPath) as? MovieCell
                else {
                    return UITableViewCell()
                }
                
                cell.populate(with: movie)
                return cell
            })
    }
    
    func applySnapshot(with movies: [MovieViewModel], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}
