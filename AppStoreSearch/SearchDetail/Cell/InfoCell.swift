//
//  InfoCell.swift
//  AppStoreSearch
//
//  Created by N17430 on 19/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var lbProvider: UILabel!
    @IBOutlet weak var lbSize: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func pressCompatitable(_ sender: UIButton) {
    }
    @IBAction func pressDevWebsite(_ sender: Any) {
    }
    @IBAction func pressPrivacy(_ sender: Any) {
    }
    
}
