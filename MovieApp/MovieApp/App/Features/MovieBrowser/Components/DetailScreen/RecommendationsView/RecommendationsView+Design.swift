import UIKit

extension RecommendationsView: DesignProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        recommendationsLabel = UILabel()
        addSubview(recommendationsLabel)

        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        addSubview(collectionView)
    }

    func styleViews() {
        backgroundColor = .clear

        recommendationsLabel.text = "Recommendations"
        recommendationsLabel.font = .heading1
        recommendationsLabel.textColor = .primaryBlue

        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 4 * offset, bottom: 0, right: 4 * offset)
        flowLayout.minimumInteritemSpacing = 2 * offset

        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }

    func defineLayoutForViews() {
        recommendationsLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(4 * offset)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(recommendationsLabel.snp.bottom).offset(5 * offset)
            $0.height.equalTo(RecommendationCell.cellSize.height)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

}
