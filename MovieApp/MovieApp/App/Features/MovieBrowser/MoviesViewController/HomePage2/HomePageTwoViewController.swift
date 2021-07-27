import UIKit

class HomePageTwoViewController: UIViewController {
    
    let offset: CGFloat = 4
    let tableRowOffset: CGFloat = 40
    
    var searchBar: MovieSearchBar!
    var tableView: UITableView!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        setupTableView()
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryCell.reuseIdentifier,
                for: indexPath) as? CategoryCell
        else {
            return UITableViewCell()
        }
        
        let mockMovie = MovieViewModel(identifier: 13, title: "Mock", overview: "Bla bla bla", posterPath: URL(string: "https://image.tmdb.org/t/p/w185/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"))
        let mockCategory = CategoryViewModel(categoryTitle: "What's popular", subcategories: [LocalSubcategory.popularStreaming, LocalSubcategory.popularOnTV, LocalSubcategory.popularForRent, LocalSubcategory.popularInTheaters], movies: [mockMovie, mockMovie, mockMovie, mockMovie, mockMovie, mockMovie, mockMovie])
        
        cell.populate(with: mockCategory)
        cell.selectionStyle = .none
        return cell
    }
    
}
