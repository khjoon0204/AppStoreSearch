import UIKit
import RxSwift
import RxCocoa

struct ReviewSection: TableViewSection {
    
    
    let numberOfItems = 1

    /// json payload 매핑되는 곳
    let lbRating: String
    let lbAnswerCount: String
    let answers: [String]

    init(lbRating: String, lbAnswerCount: String, answers: [String]) {
        self.lbRating = lbRating
        self.lbAnswerCount = lbAnswerCount
        self.answers = answers
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell{
            cell.lbRating.text = lbRating
            cell.lbAnswerCount.text = "\(lbAnswerCount)개의 평가" // TODO: Currency type 정하기(천 단위로 ',' 찍히는..)
            // TODO: - answers Observable 데이터 넣고 next
            
            return cell
        }
        return UITableViewCell()
    }
}
