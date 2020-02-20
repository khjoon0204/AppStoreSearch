import UIKit
import RxSwift
import RxCocoa

struct HelperSection: TableViewSection {
    let numberOfItems = 1

    /// json payload 매핑되는 곳

    init() {

    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HelperCell", for: indexPath) as? HelperCell{
            
            return cell
        }
        return UITableViewCell()
    }
}
