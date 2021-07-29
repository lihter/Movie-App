import UIKit

class HomePageTwoViewController: UIViewController {
    
    let offset: CGFloat = 4
    let tableRowOffset: CGFloat = 40
    
    var categories: [LocalCategory]!
    
    var searchBar: MovieSearchBar!
    var tableView: UITableView!
    var presenter: HomePageTwoPresenter!
    
    init(presenter: HomePageTwoPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
        
        categories = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupTableView()
        
        presenter.getAllCategories()
    }
    
    private func setupTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension HomePageTwoViewController: UITableViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}

extension HomePageTwoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryCell.reuseIdentifier,
                for: indexPath) as? CategoryCell
        else {
            return UITableViewCell()
        }

        cell.getSubcategoryMovies = { [weak self] subcategory in
            guard let self = self else { return [] }
            
            return self.presenter.getMovies(for: subcategory)
        }
        cell.getSubcategories = { [weak self] category in
            guard let self = self else { return [] }
            
            return self.presenter.getSubcategories(for: category)
        }
                
        cell.populate(with: categories[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}

extension HomePageTwoViewController: HomePageTwoDelegate {
    
    func addToTableView(category: LocalCategory?) {
        guard let category = category else { return }
        categories.append(category)
        tableView.reloadData()
    }
    
}
