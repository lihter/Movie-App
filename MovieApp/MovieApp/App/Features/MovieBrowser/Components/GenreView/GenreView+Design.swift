import UIKit

extension GenreView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        scrollView = UIScrollView()
        addSubview(scrollView)
        
        genresStack = UIStackView()
        scrollView.addSubview(genresStack)
    }
    
    func styleViews() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 4 * offset)
        scrollView.showsHorizontalScrollIndicator = false
        
        genresStack.alignment = .center
        genresStack.spacing = 5 * offset
        genresStack.axis = .horizontal
    }
    
    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        genresStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension GenreView {
    
    func addButtons() {
        guard let genres = genres else { return }
        
        genresStack.removeAllArrangedSubviews()
        
        for genre in genres {
            let button = UIButton()
            button.tag = genre.rawValue
            button.addTarget(self, action: #selector(genreButtonPressed), for: .touchUpInside)
            genresStack.addArrangedSubview(button)
        }
    }
    
    func styleButtons() {
        for button in genresStack.arrangedSubviews {
            guard let button = button as? UIButton else { continue }
            
            if button.tag == selectedGenre {
                styleSelectedGenre(button)
            } else {
                styleUnselectedGenre(button)
            }
        }
    }
    
    func styleSelectedGenre(_ button: UIButton) {
        button.setAttributedTitle(
            NSAttributedString(
                string: Genre(rawValue: button.tag)?.genreName ?? "_",
                attributes: [
                    .font: UIFont.regularBold,
                    .underlineStyle: NSUnderlineStyle.thick.rawValue,
                    .underlineColor: UIColor.black,
                    .foregroundColor: UIColor.black
                ]),
            for: .normal)
    }
    
    func styleUnselectedGenre(_ button: UIButton) {
        let font = UIFont.regularSemiBold
        button.setAttributedTitle(
            NSAttributedString(
                string: Genre(rawValue: button.tag)?.genreName ?? "_",
                attributes: [
                    .font: font,
                    .foregroundColor: UIColor.secondaryGray]),
            for: .normal)
    }
    
    @objc func genreButtonPressed(sender: UIButton) {
        guard
            let selected = selectedGenre,
            let button = genresStack
                .arrangedSubviews
                .first(where: { ($0 as? UIButton)?.tag == selected }) as? UIButton
        else {
            return
        }
        
        styleUnselectedGenre(button)
        styleSelectedGenre(sender)
        selectedGenre = sender.tag
        delegate?.changeGenre(to: Genre(rawValue: selectedGenre!), resetOffset: true)
    }
    
}
