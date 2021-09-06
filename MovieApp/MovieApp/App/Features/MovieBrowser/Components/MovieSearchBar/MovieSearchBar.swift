import UIKit

class MovieSearchBar: UIView {

    let searchBarHeight: CGFloat = 40
    let offset: CGFloat = 4
    let grayFieldCornerRadius: CGFloat = 10
    let deleteTextButtonHeight: CGFloat = 12

    weak var delegate: MovieSearchBarDelegate?

    var searchGrayFieldView: UIView!
    var searchBarIconImageView: UIImageView!
    var searchTextField: UITextField!
    var cancelButton: UIButton!
    var deleteTextButton: UIButton!

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDelegate(delegate: MovieSearchBarDelegate) {
        self.delegate = delegate
    }

}
