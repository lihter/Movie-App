import UIKit

class GenreView: UIView {

    static let height: CGFloat = 40

    let offset: CGFloat = 4

    var selectedGenre: Int!
    var genres: [Genre]?

    weak var delegate: CategoryCellDelegate?
    var scrollView: UIScrollView!
    var genresStack: UIStackView!

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDelegate(delegate: CategoryCellDelegate) {
        self.delegate = delegate
    }

    func populate(with genres: [Genre]?) {
        guard
            let genres = genres,
            !genres.isEmpty
        else {
            return
        }

        self.genres = genres
        selectedGenre = selectedGenre ?? self.genres?[0].rawValue
        addButtons()
        delegate?.changeGenre(to: Genre(rawValue: selectedGenre!), resetOffset: false)

        styleButtons()
    }

}
