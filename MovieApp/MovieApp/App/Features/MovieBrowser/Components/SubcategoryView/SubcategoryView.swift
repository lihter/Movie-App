import UIKit

class SubcategoryView: UIView {
    
    static let height: CGFloat = 40
    
    var selectedSubcategory: Int = 0
    var subcategories: [String]? = nil
    
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
    
    func populate(with subcategories: [String]) {
        self.subcategories = subcategories
        
        addButtons()
        styleButtons()
    }
}
