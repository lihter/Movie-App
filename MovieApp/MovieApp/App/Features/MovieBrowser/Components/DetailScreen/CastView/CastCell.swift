import UIKit

class CastCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: CastCell.self)
    static let cellSize = CGSize(width: 125, height: 210)

    let offset: CGFloat = 4

    var nameLabel: UILabel!
    var characterNameLabel: UILabel!
    var portraitImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func populate(withPerson person: CastViewModel) {
        nameLabel.text = person.name
        characterNameLabel.text = person.characterName
        portraitImageView.kf.setImage(with: person.posterPath)
    }

}
