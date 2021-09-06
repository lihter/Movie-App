import UIKit

extension UIStackView {

    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }

}
