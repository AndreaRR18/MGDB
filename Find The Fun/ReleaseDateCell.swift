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
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: ReleaseDatePlatformTableViewCell.cellIdentifier) as? ReleaseDatePlatformTableViewCell) ?? ReleaseDatePlatformTableViewCell.fromXIB

//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.releaseDatePlatformTableViewCell, for: indexPath) as! ReleaseDatePlatformTableViewCell

        cell.backgroundColor = ColorUI.background
        guard let platform = releaseDate.platform else { return cell }
        PlatformCoreData.namePlatformDB(
            id: platform,
            callback: { getTuple in
                do {
                        let (namePlatform, new) = try getTuple()
                    cell.configureReleaseDateTableViewCell(namePlatform, self.releaseDate.human)
                    if new {
                        tableView.reloadData()
                    }
                } catch let error {
                    handleError(error)
                }
        })
        
        return cell
    }
}
