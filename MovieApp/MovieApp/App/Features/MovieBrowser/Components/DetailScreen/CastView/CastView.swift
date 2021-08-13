import UIKit

class CastView: UIView {
        
    let offset: CGFloat = 4
    
    var cast: [CastViewModel]?
    
    var titleLabel: UILabel!
    var fullCastButton: UIButton!
    var flowLayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
        
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func populate(with cast: [CastViewModel]) {
        self.cast = cast
        collectionView.reloadData()
    }
    
}

extension CastView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CastCell.reuseIdentifier,
                for: indexPath) as? CastCell,
            let person = cast?[indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        cell.populate(withPerson: person)
        return cell
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

