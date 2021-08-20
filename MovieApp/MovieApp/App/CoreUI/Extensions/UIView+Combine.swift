import Combine
import UIKit

extension UIView {

    func publisher(for gestureType: GestureType) -> GesturePublisher {
        GesturePublisher(view: self, gestureType: gestureType)
    }

    func tapGesture() -> GesturePublisher {
        publisher(for: .tap())
    }

    func swipeGesture(_ direction: UISwipeGestureRecognizer.Direction) -> GesturePublisher {
        publisher(for: .swipe(direction))
    }

    func throttledTapGesture(for interval: Double = 0.5) -> AnyPublisher<GesturePublisher.Output, Never> {
        tapGesture()
            .throttle(for: .seconds(interval), scheduler: RunLoop.main, latest: true)
            .eraseToAnyPublisher()
    }

}
