//
//  DescCell.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

class DescCell: UITableViewCell {
    @IBOutlet weak var artWork: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var screenCV: UICollectionView!
    
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
    @IBAction func pressShare(_ sender: UIButton) {
    }
    
}
