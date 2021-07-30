import UIKit

extension SubcategoryView: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        scrollView = UIScrollView()
        addSubview(scrollView)
        
        subcategoriesStack = UIStackView()
        scrollView.addSubview(subcategoriesStack)
    }
    
    func styleViews() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 4 * offset)
        scrollView.showsHorizontalScrollIndicator = false
        
        subcategoriesStack.alignment = .center
        subcategoriesStack.spacing = 5 * offset
        subcategoriesStack.axis = .horizontal
    }
    
    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subcategoriesStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension SubcategoryView {
    
    func addButtons() {
        guard let subcategories = subcategories else { return }
        
        subcategoriesStack.removeAllArrangedSubviews()
        
        for subcategory in subcategories {
            let button = UIButton()
            button.tag = subcategory.rawValue
            button.addTarget(self, action: #selector(subcategoryButtonPressed), for: .touchUpInside)
            subcategoriesStack.addArrangedSubview(button)
        }
    }
    
    func styleButtons() {
        for button in subcategoriesStack.arrangedSubviews {
            guard let button = button as? UIButton else { continue }
            
            if button.tag == selectedSubcategory {
                styleSelectedSubcategory(button)
            } else {
                styleUnselectedSubcategory(button)
            }
        }
    }
    
    func styleSelectedSubcategory(_ button: UIButton) {
        button.setAttributedTitle(
            NSAttributedString(
                string: LocalSubcategory(rawValue: button.tag)?.description ?? "_",
                attributes: [
                    .font: UIFont.regularBold,
                    .underlineStyle: NSUnderlineStyle.thick.rawValue,
                    .underlineColor: UIColor.black,
                    .foregroundColor: UIColor.black
                ]),
            for: .normal)
    }
    
    func styleUnselectedSubcategory(_ button: UIButton) {
        let font = UIFont.regularSemiBold
        button.setAttributedTitle(
            NSAttributedString(
                string: LocalSubcategory(rawValue: button.tag)?.description ?? "_",
                attributes: [
                    .font: font,
                    .foregroundColor: UIColor.secondaryGray]),
            for: .normal)
    }
    
    @objc func subcategoryButtonPressed(sender: UIButton) {
        guard
            let selected = selectedSubcategory,
            let button = subcategoriesStack
                .arrangedSubviews
                .first(where: { ($0 as? UIButton)?.tag == selected }) as? UIButton
        else {
            return
        }
        
        styleUnselectedSubcategory(button)
        styleSelectedSubcategory(sender)
        selectedSubcategory = sender.tag
        delegate?.changeSubcategory(to: LocalSubcategory(rawValue: selectedSubcategory!))
    }
    
}
