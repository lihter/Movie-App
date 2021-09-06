import Combine
import UIKit

class CastView: UIView {
    
    typealias DataSource = UICollectionViewDiffableDataSource<CastSection, CastViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CastSection, CastViewModel>
        
    let offset: CGFloat = 4
    
    var titleLabel: UILabel!
    var fullCastButton: UIButton!
    var flowLayout: UICollectionViewFlowLayout!
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
    
    private func setupCollectionView() {
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.reuseIdentifier)
        collectionView.delegate = self
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, person) -> UICollectionViewCell? in
                guard
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CastCell.reuseIdentifier,
                        for: indexPath) as? CastCell
                else {
                    return UICollectionViewCell()
                }
                
                cell.populate(withPerson: person)
                return cell
            })
        return dataSource
    }
    
    func applySnapshot(with cast: [CastViewModel], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems(cast)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension CastView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
    
}

extension CastView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CastCell.cellSize
    }
    
}

