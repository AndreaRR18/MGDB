import Foundation
import UIKit

class HeaderCell: CellFactory {
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: CoverHDTableViewCell.cellIdentifier) as? CoverHDTableViewCell) ?? CoverHDTableViewCell.fromXIB
        
        cell.configureCoverHDTableViewCell()
        
        return cell
    }
}
