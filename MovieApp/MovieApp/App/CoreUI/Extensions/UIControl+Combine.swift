import Combine
import UIKit

extension UIControl {

    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        UIControlPublisher(control: self, events: events)
    }

    func tap() -> UIControlPublisher<UIControl> {
        publisher(for: .touchUpInside)
    }

    func throttledTap(for interval: Double = 0.5) -> AnyPublisher<UIControl, Never> {
        tap()
            .throttle(for: .seconds(interval), scheduler: RunLoop.main, latest: true)
            .eraseToAnyPublisher()
    }

}
