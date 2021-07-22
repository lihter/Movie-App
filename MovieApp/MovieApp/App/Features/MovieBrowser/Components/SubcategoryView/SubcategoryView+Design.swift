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
        
        addButtons()
    }
    
    func styleViews() {
        scrollView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 0)
        scrollView.showsHorizontalScrollIndicator = false
        
        subcategoriesStack.alignment = .center
        subcategoriesStack.spacing = 5 * offset
        subcategoriesStack.axis = .horizontal
        
        styleButtons()
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
        for tag in 0..<maxNumberOfSubcategoryItems {
            let button = UIButton()
            button.tag = tag
            button.addTarget(self, action: #selector(subcategoryButtonPressed), for: .touchUpInside)
            subcategoriesStack.addArrangedSubview(button)
        }
    }
    
    func styleButtons() {
        for button in subcategoriesStack.arrangedSubviews {
            if let button = button as? UIButton {
                if(button.tag == selectedSubcategory) {
                    styleSelectedSubcategory(button)
                } else {
                    styleUnselectedSubcategory(button)
                }
            }
        }
    }
    
    func styleSelectedSubcategory(_ button: UIButton) {
        let font = UIFont(name: Fonts.proximaBold, size: 16) ?? .systemFont(ofSize: 16)
        button.setAttributedTitle(NSAttributedString(
                                    string: "Subcategory",
                                    attributes: [NSAttributedString.Key.font: font,
                                                 NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                 NSAttributedString.Key.underlineColor: UIColor.black,
                                                 NSAttributedString.Key.foregroundColor: UIColor.black]),
                                  for: .normal)
    }
    
    func styleUnselectedSubcategory(_ button: UIButton) {
        let font = UIFont(name: Fonts.proximaNovaSemiBold, size: 16) ?? .systemFont(ofSize: 16)
        button.setAttributedTitle(NSAttributedString(
                                    string: "Subcategory",
                                    attributes: [NSAttributedString.Key.font: font,
                                                 NSAttributedString.Key.foregroundColor: UIColor.secondaryGray]),
                                  for: .normal)
    }
    
    @objc func subcategoryButtonPressed(sender: UIButton) {
        if let button = subcategoriesStack.arrangedSubviews[selectedSubcategory] as? UIButton {
            styleUnselectedSubcategory(button)
            styleSelectedSubcategory(sender)
            selectedSubcategory = sender.tag
        }
    }
    
}
