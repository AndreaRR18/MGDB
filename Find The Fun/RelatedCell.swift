import Foundation
import UIKit

class RelatedCell: CellFactory {
    
    private let genre: [Int]
    
    
    init(_ genre: [Int]) {
        self.genre = genre
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        navigationController.navigationBar.isTranslucent = false
        
        tableView.deselectRow(
            at: indexPath,
            animated: true)
        
        navigationController.pushViewController(
            RelatedTableViewController(idGenres: genre),
            animated: true)
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: RelatedInDescriptionTableViewCell.cellIdentifier) as? RelatedInDescriptionTableViewCell) ?? RelatedInDescriptionTableViewCell.fromXIB

//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.relatedInDescriptionTableViewCell, for: indexPath) as! RelatedInDescriptionTableViewCell
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
}
