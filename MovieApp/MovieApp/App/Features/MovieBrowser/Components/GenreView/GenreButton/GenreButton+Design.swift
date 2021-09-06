import UIKit

extension GenreButton: DesignProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        button = UIButton()
        addSubview(button)

        underline = UIView()
        addSubview(underline)
    }

    func styleViews() {
        underline.backgroundColor = .primaryBlue
    }

    func defineLayoutForViews() {
        button.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        underline.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
        }
    }

    func styleSelectedGenre() {
        button.setAttributedTitle(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.regularBold,
                    .foregroundColor: UIColor.black
                ]),
            for: .normal)
        underline.isHidden = false
    }

    func styleUnselectedGenre() {
        let font = UIFont.regularSemiBold
        button.setAttributedTitle(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: font,
                    .foregroundColor: UIColor.secondaryGray]),
            for: .normal)
        underline.isHidden = true
    }

}
