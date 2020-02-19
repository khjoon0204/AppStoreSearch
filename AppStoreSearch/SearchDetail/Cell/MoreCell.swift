//
//  MoreCell.swift
//  AppStoreSearch
//
//  Created by N17430 on 19/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var btnDeveloper: UIButton!
    @IBOutlet weak var nameDeveloper: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func pressShowMore(_ sender: Any) {
    }
    @IBAction func pressDeveloper(_ sender: Any) {
    }
    
}
