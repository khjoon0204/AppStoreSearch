//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell

}

protocol TableViewSection {
    var numberOfItems: Int { get }    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
}
