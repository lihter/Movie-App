import UIKit

extension UIImage {

    convenience init(with bundleImage: BundleImage) {
        self.init(named: bundleImage.rawValue)!
    }

}
