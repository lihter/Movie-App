import UIKit

class MovieDetailViewController: UIViewController {
    
    let movieId: Int!
    
    init(withMovieId movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        print(movieId ?? 0)
    }
    
}
