//
//  ReviewCell.swift
//  AppStoreSearch
//
//  Created by N17430 on 19/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbAnswerCount: UILabel!
    @IBOutlet weak var answerCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func pressShowAll(_ sender: UIButton) {
    }
    
}
