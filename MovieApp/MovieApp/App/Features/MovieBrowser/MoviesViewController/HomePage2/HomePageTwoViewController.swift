import UIKit

class HomePageTwoViewController: UIViewController {
    
    let offset: CGFloat = 4
    let tableRowOffset: CGFloat = 40
    
    var categories: [CategoryViewModel]!
    
    var searchBar: MovieSearchBar!
    var tableView: UITableView!
    var presenter: HomePageTwoPresenter!
    
    init(presenter: HomePageTwoPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
        
        self.categories = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupTableView()
        
        presenter.getPopularMovies()
        presenter.getTrendingMovies()
        presenter.getTopRatedMovies()
    }
    
    private func setupTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension HomePageTwoViewController: UITableViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

}

extension HomePageTwoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryCell.reuseIdentifier,
                for: indexPath) as? CategoryCell
        else {
            return UITableViewCell()
        }

        cell.populate(with: categories[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}

extension HomePageTwoViewController: HomePageTwoDelegate {
    
    func addToTableView(category: CategoryViewModel?) {
        guard let category = category else { return }
        
        categories.append(category)
        tableView.reloadData()
    }
    
}
