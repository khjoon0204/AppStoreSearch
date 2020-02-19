//
//  NewCell.swift
//  AppStoreSearch
//
//  Created by N17430 on 19/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

class NewCell: UITableViewCell {

    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var lbBeforeDay: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func pressMore(_ sender: UIButton) {
    }
    
}
