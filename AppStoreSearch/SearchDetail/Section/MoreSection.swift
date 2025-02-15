//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct MoreSection: TableViewSection {
    let numberOfItems = 1

    /// json payload 매핑되는 곳
    let txt: String
    let nameDeveloper: String

    init(txt: String, nameDeveloper: String) {
        self.txt = txt
        self.nameDeveloper = nameDeveloper
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as? MoreCell{
            cell.txt.text = txt
            cell.nameDeveloper.text = nameDeveloper
            return cell
        }
        return UITableViewCell()
    }
    
}
