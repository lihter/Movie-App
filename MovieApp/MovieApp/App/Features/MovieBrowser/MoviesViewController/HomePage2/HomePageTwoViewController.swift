import UIKit

class HomePageTwoViewController: UIViewController {
    
    let offset: CGFloat = 4
    let tableRowOffset: CGFloat = 40
    
    var categories: [LocalCategory]!
    var storedCVOffsets: [Int: CGFloat]!
    var storedSelectedGenres: [Int: Int]!
    
    var searchBar: MovieSearchBar!
    var tableView: UITableView!
    var presenter: HomePageTwoPresenter!
    
    init(presenter: HomePageTwoPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
        
        categories = []
        storedCVOffsets = [:]
        storedSelectedGenres  = [:]
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
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
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

        cell.getGenreMovies = { [weak self] category, genreId in
            guard let self = self else { return [] }
            
            return self.presenter.getMovies(for: category, genreId: genreId)
        }
        cell.getGenres = { [weak self] category in
            guard let self = self else { return [] }
            
            return self.presenter.getGenres(for: category)
        }
        cell.showDetailScreen = { [weak self] movieId in
            guard let self = self else { return }
            
            self.presenter.showDetailScreen(for: movieId)
        }
        cell.favoritePressed = { [weak self] movieId in
            guard let self = self else { return }
            
            self.presenter.toggleFavorite(movieId)
        }
        
        cell.populate(with: categories[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CategoryCell else { return }
        
        cell.genresView.selectedGenre = storedSelectedGenres[indexPath.row] ?? cell.genresView.selectedGenre
        cell.collectionViewOffset = storedCVOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CategoryCell else { return }
        
        storedSelectedGenres[indexPath.row] = cell.genresView.selectedGenre
        storedCVOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
}

extension HomePageTwoViewController: HomePageTwoDelegate {
    
    func addToTableView(category: LocalCategory?) {
        guard let category = category else { return }
        
        categories.append(category)
        tableView.reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}
