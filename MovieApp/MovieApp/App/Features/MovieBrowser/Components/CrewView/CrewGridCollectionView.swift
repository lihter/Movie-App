import Combine
import UIKit

class CrewGridCollectionView: UIView {

    typealias DataSource = UICollectionViewDiffableDataSource<CrewSection, CrewViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CrewSection, CrewViewModel>

    let spacing: CGFloat = 8
    let numberOfColumns: Int = 3

    var numberOfRows: Int = 0 {
        didSet {
            collectionView.snp.updateConstraints {
                $0.height.equalTo(numberOfRows * 60)
            }
        }
    }

    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    lazy var dataSource = makeDataSource()

    private var disposables = Set<AnyCancellable>()

    init() {
        super.init(frame: .zero)

        buildViews()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCollectionView() {
        collectionView.register(CrewCell.self, forCellWithReuseIdentifier: CrewCell.reuseIdentifier)
        collectionView.delegate = self
    }

    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, crewMember) -> UICollectionViewCell? in
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CrewCell.reuseIdentifier,
                        for: indexPath) as? CrewCell
                else {
                    return UICollectionViewCell()
                }

                cell.populate(with: crewMember)
                return cell
            })
        return dataSource
    }

    func applySnapshot(with crew: [CrewViewModel], animatingDifferences: Bool = true) {
        numberOfRows = Int(ceil(Double(crew.count) / 3.0))

        var snapshot = Snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(crew)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

}

extension CrewGridCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidth = (bounds.width - CGFloat((numberOfColumns - 1)) * spacing) / CGFloat(numberOfColumns)

        return CGSize(width: cellWidth, height: CrewCell.height)
    }

}
