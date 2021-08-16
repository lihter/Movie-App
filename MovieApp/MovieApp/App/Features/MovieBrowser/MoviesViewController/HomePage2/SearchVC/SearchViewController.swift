import UIKit

class SearchViewController: UIViewController {
    
    let offset: CGFloat = 4
    
    var movies: [MovieViewModel]?
    
    var tableView: UITableView!
    var presenter: SearchPresenter!
    
    init(presenter: SearchPresenter) {
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension SearchViewController: UITableViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieCell.reuseIdentifier,
                for: indexPath) as? MovieCell,
            let movie = movies?[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.populate(with: movie)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MovieCell else { return }
        
        presenter.selectedMovie(withId: cell.movieId)
    }
    
}

extension SearchViewController: SearchDelegate {
    
    func showSearchedMovies(_ movies: [MovieViewModel]) {
        self.movies = movies
        tableView.reloadData()
    }
    
}


