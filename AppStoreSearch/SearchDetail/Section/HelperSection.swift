import UIKit
import RxSwift
import RxCocoa

struct HelperSection: TableViewSection {
    
    
    let numberOfItems = 1

    /// json payload 매핑되는 곳
    let artWork: String
    let trackName: String
    let url_obs: [String]
    let screenshotUrls: [String]

    init(artWork: String, trackName: String, url_obs: [String], screenshotUrls: [String]) {
        self.artWork = artWork
        self.trackName = trackName
        self.url_obs = url_obs
        self.screenshotUrls = screenshotUrls
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HelperCell", for: indexPath) as? HelperCell{
            if let artWorkUrl = URL(string: artWork){
                artWorkUrl.loadURLImage { (data, image) in
                    cell.artWork.image = image
                }
            }
            cell.url_obs.accept(screenshotUrls.map{(URL(string: $0)!)})
            cell.trackName.text = trackName
            
            return cell
        }
        return UITableViewCell()
    }
}
