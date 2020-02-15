//
//  ItemCell.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var artwork60: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var screenShot1: UIImageView!
    @IBOutlet weak var screenShot2: UIImageView!
    @IBOutlet weak var screenShot3: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func pressReceive(_ sender: UIButton) {
        
    }
    
}
