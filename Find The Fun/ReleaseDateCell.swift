import Foundation
import UIKit

class ReleaseDateCell: CellFactory {
    
    private let releaseDate: ReleaseDate
    
    
    init(_ releaseDate: ReleaseDate) {
        self.releaseDate = releaseDate
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.releaseDatePlatformTableViewCell, for: indexPath) as! ReleaseDatePlatformTableViewCell

        cell.backgroundColor = ColorUI.background
        
        PlatformCoreData.namePlatformDB(
            id: releaseDate.platform,
            callback: { namePlatform, new in
                cell.configureReleaseDateTableViewCell(namePlatform, self.releaseDate.human)
                if new {
                    tableView.reloadData()
                }
        })
        
        return cell
    }
}
