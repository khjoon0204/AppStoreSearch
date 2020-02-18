import UIKit

final class InputTextCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    override func prepareForReuse() {
        // TODO: 재사용시 초기화 처리
        titleLabel.text = ""
    }
}
