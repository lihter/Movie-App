import UIKit

class SubcategoryView: UIView {
    
    static let height: CGFloat = 40
    
    var selectedSubcategory: Int? = nil
    var subcategories: [LocalSubcategory]? = nil
    
    let offset: CGFloat = 4
    let maxNumberOfSubcategoryItems: Int = 8
    
    var scrollView: UIScrollView!
    var subcategoriesStack: UIStackView!
    
    init() {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(with subcategories: [LocalSubcategory]) {
        self.subcategories = subcategories
                
        if subcategoriesStack.arrangedSubviews.isEmpty {
            selectedSubcategory = self.subcategories?[0].rawValue
            addButtons()
        }
        styleButtons()
    }
}
