import UIKit
import RxSwift
import RxCocoa

struct InfoSection: TableViewSection {
    let numberOfItems = 1

    /// json payload 매핑되는 곳
    let lbProvider: String
    let lbSize: String
    let lbCategory: String
    let lbAge: String

    init(lbProvider: String, lbSize: String, lbCategory: String, lbAge: String) {
        self.lbProvider = lbProvider
        self.lbSize = lbSize
        self.lbCategory = lbCategory
        self.lbAge = lbAge
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell{
            
            cell.lbProvider.text = lbProvider
            cell.lbSize.text = lbSize
            cell.lbCategory.text = lbCategory
            cell.lbAge.text = lbAge
            
            return cell
        }
        return UITableViewCell()
    }
}
