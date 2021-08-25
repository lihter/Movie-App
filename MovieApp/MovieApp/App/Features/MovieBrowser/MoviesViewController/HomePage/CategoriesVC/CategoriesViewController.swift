import Combine
import UIKit

class CategoriesViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<CategoriesSection, LocalCategory>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CategoriesSection, LocalCategory>
    
    let offset: CGFloat = 4
    let tableRowOffset: CGFloat = 40
    
    var storedCVOffsets: [Int: CGFloat]!
    var storedSelectedGenres: [Int: Int]!
    
    var tableView: UITableView!
    var presenter: CategoriesPresenter!
    lazy var dataSource = makeDataSource()
    
    private var disposables = Set<AnyCancellable>()
    
    init(presenter: CategoriesPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        
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
        
        setCategories()
    }
    
    private func setCategories() {
        let categories = presenter.getCategories()
        applySnapshot(with: categories)
    }
    
    private func setupTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
    }
    
    private func makeDataSource() -> DataSource {
        DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, category) -> UITableViewCell? in
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: CategoryCell.reuseIdentifier,
                        for: indexPath) as? CategoryCell
                else {
                    return UITableViewCell()
                }
                
                cell.getGenres = { [weak self] category in
                    guard let self = self else { return [] }
                    
                    return self.presenter.getGenres(for: category)
                }
                cell.getGenreMovies = { [weak self] category, genreId in
                    guard let self = self else { return .empty() }
                    
                    return self.presenter.getMoviesPublisher(for: category, genreId: genreId)
                }
                cell.showDetailScreen = { [weak self] movieId in
                    guard let self = self else { return }
                    
                    self.presenter.selectedMovie(withId: movieId)
                }
                cell.favoritePressed = { [weak self] movieId in
                    guard let self = self else { return }
                    
                    self.presenter.toggleFavorite(movieId)
                }
                
                cell.populate(with: category)
                cell.selectionStyle = .none
                return cell
            })
    }
    
    private func applySnapshot(with categories: [LocalCategory], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension CategoriesViewController: UITabBarDelegate {
    
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
