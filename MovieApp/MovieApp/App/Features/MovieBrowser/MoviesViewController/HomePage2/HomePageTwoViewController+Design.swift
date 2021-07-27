import UIKit

extension HomePageTwoViewController: DesignProtocol {
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        navigationView = MovieAppNavigationView()
        view.addSubview(navigationView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func defineLayoutForViews() {
        navigationView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
    }
    
}
