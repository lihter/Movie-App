import UIKit

class ProgressBarView: UIView {
    
    var endPoint: Int!
    
    var circleLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    var percentageLabel: UILabel!
    var userScoreLabel: UILabel!
    
    init(percentage endPoint: Int) {
        super.init(frame: .zero)
        
        self.endPoint = endPoint
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
}
