import UIKit

class SubcategoryView: UIView {
    
    static let height: CGFloat = 40
    
    let offset: CGFloat = 4
    let maxNumberOfSubcategoryItems: Int = 8
    
    var selectedSubcategory: Int? = nil
    var subcategories: [LocalSubcategory]? = nil
    
    weak var delegate: CategoryCellDelegate?
    var scrollView: UIScrollView!
    var subcategoriesStack: UIStackView!
    
    init() {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: CategoryCellDelegate) {
        self.delegate = delegate
    }
    
    func populate(with subcategories: [LocalSubcategory]?) {
        guard let subcategories = subcategories else { return }
        
        if !subcategories.isEmpty {
            self.subcategories = subcategories
            selectedSubcategory = self.subcategories?[0].rawValue
            addButtons()
            delegate?.changeSubcategory(to: LocalSubcategory(rawValue: selectedSubcategory!))

            styleButtons()
        }
    }
    
}
