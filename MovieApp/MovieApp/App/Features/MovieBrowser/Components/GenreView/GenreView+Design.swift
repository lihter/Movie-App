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
            let button = GenreButton(title: genre.genreName)
            button.tag = genre.rawValue
            button.addTarget(self, action: #selector(genreButtonPressed), for: .touchUpInside)
            genresStack.addArrangedSubview(button)
        }
    }

    func styleButtons() {
        for button in genresStack.arrangedSubviews {
            guard let button = button as? GenreButton else { continue }

            if button.tag == selectedGenre {
                button.styleSelectedGenre()
            } else {
                button.styleUnselectedGenre()
            }
        }
    }

    @objc func genreButtonPressed(sender: UIButton) {
        let view = genresStack
            .arrangedSubviews
            .first(where: { view in
                guard let genresButton = view as? GenreButton else { return false }
                return genresButton.button == sender
            })

        guard
            let selected = selectedGenre,
            let oldButton = genresStack
                .arrangedSubviews
                .first(where: { ($0 as? GenreButton)?.tag == selected }) as? GenreButton,
            let newButton = view as? GenreButton
        else {
            return
        }

        oldButton.styleUnselectedGenre()
        newButton.styleSelectedGenre()
        selectedGenre = newButton.tag
        delegate?.changeGenre(to: Genre(rawValue: selectedGenre!), resetOffset: true)
    }

}
