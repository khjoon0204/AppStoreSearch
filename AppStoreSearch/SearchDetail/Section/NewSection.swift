//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct NewSection: TableViewSection {
    let numberOfItems = 1

    /// json payload 매핑되는 곳
    let lbVersion: String
    let lbBeforeDay: String
    let lbDesc: String

    init(lbVersion: String, lbBeforeDay: String, lbDesc: String) {
        self.lbVersion = lbVersion
        self.lbBeforeDay = lbBeforeDay
        self.lbDesc = lbDesc
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as? NewCell{
            
            cell.lbVersion.text = "버전 \(lbVersion)"
            cell.lbBeforeDay.text = lbBeforeDay
            cell.lbDesc.text = lbDesc
            
            return cell
        }
        return UITableViewCell()
    }
}
