import UIKit

class CrewGridCollectionView: UIView {
    
    let spacing: CGFloat = 8
    let numberOfColumns: Int = 3
    
    var crew: [CrewViewModel]!
    var numberOfRows: Int = 0 {
        didSet {
            collectionView.snp.updateConstraints {
                $0.height.equalTo(numberOfRows * 60)
            }
        }
    }
    
    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        
        crew = []
        
        buildViews()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView.register(CrewCell.self, forCellWithReuseIdentifier: CrewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func populate(with crew: [CrewViewModel]) {
        self.crew = crew
        numberOfRows = Int(ceil(Double(crew.count) / 3.0))

        collectionView.reloadData()
    }
    
}

extension CrewGridCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crew.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CrewCell.reuseIdentifier,
                for: indexPath) as? CrewCell,
            let crewMember = crew?[indexPath.item]
        else {
            return UICollectionViewCell()
        }

        cell.populate(with: crewMember)
        return cell
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
