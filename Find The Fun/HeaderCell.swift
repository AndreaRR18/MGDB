import Foundation
import UIKit

class HeaderCell: CellFactory {
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CoverHDTableViewCell.cellIdentifier) as? CoverHDTableViewCell) ?? CoverHDTableViewCell.fromXIB

//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverHDTableViewCell, for: indexPath) as! CoverHDTableViewCell
        
        cell.configureCoverHDTableViewCell()
        
        return cell
    }
}
