import UIKit

extension ProgressBarView: DesignProtocol {
    
    func buildViews() {
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer)
        
        progressLayer = CAShapeLayer()
        layer.addSublayer(progressLayer)
        
        percentageLabel = UILabel()
        addSubview(percentageLabel)
        
        userScoreLabel = UILabel()
        addSubview(userScoreLabel)
    }
    
    func styleViews() {
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 5.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.progressBarGreen.withAlphaComponent(0.3).cgColor

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.progressBarGreen.cgColor

        let text = NSMutableAttributedString(string: "\(endPoint ?? 0)%")
        text.setAttributes(
            [.font: UIFont.extraSmallBold, .foregroundColor: UIColor.white],
            range: NSMakeRange(0, text.length))
        text.setAttributes(
            [.font: UIFont.regularBold, .foregroundColor: UIColor.white],
            range: NSMakeRange(0, text.length - 1))
        percentageLabel.attributedText = text
        
        userScoreLabel.text = "User Score"
        userScoreLabel.textColor = .white
        userScoreLabel.font = .regularBold
    }
    
    func defineLayoutForViews() {
        percentageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(-10.5)
            $0.top.equalToSuperview().offset(-7)
        }
        
        userScoreLabel.snp.makeConstraints {
            $0.leading.equalTo(percentageLabel.snp.trailing).offset(15)
            $0.centerY.equalTo(percentageLabel.snp.centerY)
        }
    }
    
}
