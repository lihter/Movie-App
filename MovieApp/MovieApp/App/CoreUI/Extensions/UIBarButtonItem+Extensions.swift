import Combine
import UIKit

extension UIBarButtonItem {

    var tap: BarItemGesturePublisher {
        BarItemGesturePublisher(barItem: self)
    }

}
