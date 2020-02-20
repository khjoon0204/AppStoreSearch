//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

final class TitleCell: UICollectionViewCell {
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
