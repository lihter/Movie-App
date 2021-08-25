import UIKit

class ProgressBarView: UIView {
    
    var endPoint: Int!
    
    var circleLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    var percentageLabel: UILabel!
    var userScoreLabel: UILabel!
    var circularPath: UIBezierPath!
    var progressPath: UIBezierPath!
    
    init() {
        super.init(frame: .zero)
        
        endPoint = 0
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPercentage(to endPoint: Int) {
        let hasDifferentValue = self.endPoint != endPoint
        
        self.endPoint = endPoint
        
        buildViews()
        if hasDifferentValue {
            progressAnimation(duration: 1.2)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circularPath = UIBezierPath(
            arcCenter: CGPoint(x: 0, y: frame.size.height / 2.0),
            radius: 21,
            startAngle: CGFloat(-Double.pi / 2),
            endAngle: CGFloat(3 * Double.pi / 2),
            clockwise: true)
        
        progressPath = UIBezierPath(
            arcCenter: CGPoint(x: 0, y: frame.size.height / 2.0),
            radius: 21,
            startAngle: CGFloat(-Double.pi / 2),
            endAngle: CGFloat(endPoint) * 0.06283185307179 + CGFloat(-Double.pi / 2),
            clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        progressLayer.path = progressPath.cgPath
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
