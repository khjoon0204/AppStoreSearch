//
//  DescCell.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DescCell: UITableViewCell {
    @IBOutlet weak var artWork: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var screenCV: UICollectionView!
    
    var bag: DisposeBag?
    var url_obs = BehaviorRelay<[URL]>(value: [])
    
//    var title: String? {
//        didSet {
//            titleLabel.text = title
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        screenCV.register(UINib(nibName: "DescScreenCell", bundle: nil), forCellWithReuseIdentifier: "DescScreenCell")
        configureCV()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.bag = nil
    }
    
    func configureCV(){
        let disposeBag = DisposeBag()

        url_obs
            .bind(to: self.screenCV.rx.items(cellIdentifier: "DescScreenCell", cellType: DescScreenCell.self)) { (idx, url, cell) in                
                url.loadURLImage { (data, image) in
                    cell.iv.image = image
                }
        }
        .disposed(by: disposeBag)
        
        
        bag = disposeBag
    }
    
    @IBAction func pressReceive(_ sender: UIButton) {
        
    }
    @IBAction func pressShare(_ sender: UIButton) {
        
    }
    
}
