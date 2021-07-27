import UIKit

class HomePageTwoViewController: UIViewController {
    
    let offset: CGFloat = 4
    
    var navigationView: MovieAppNavigationView!
    var searchBar: MovieSearchBar!
<<<<<<< HEAD
    var subcategoryView: SubcategoryView!
    var moviesCollectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
=======
<<<<<<< HEAD
    var subcategoryView: SubcategoryView!
=======
>>>>>>> develop
>>>>>>> develop
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
<<<<<<< HEAD
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        moviesCollectionView.register(NewMovieCell.self, forCellWithReuseIdentifier: NewMovieCell.reuseIdentifier)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
    }
    
}

extension HomePageTwoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewMovieCell.reuseIdentifier,
                for: indexPath) as? NewMovieCell
        else {
            return UICollectionViewCell()
        }
        let mockMovie = MovieViewModel(identifier: 13, title: "Mock", overview: "Bla bla bla", posterPath: URL(string: "https://image.tmdb.org/t/p/w185/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg"))
        
        cell.populate(withMovie: mockMovie)
        return cell
    }
    
}

extension HomePageTwoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return NewMovieCell.cellSize
=======
>>>>>>> develop
    }
    
}
