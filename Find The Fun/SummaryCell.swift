import Foundation
import UIKit

class SummaryCell: CellFactory {
    
    private let summary: String?
    
    init(_ summary: String?) {
        self.summary = summary
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.cellIdentifier) as? SummaryTableViewCell) ?? SummaryTableViewCell.fromXIB

//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.summaryTableViewCell, for: indexPath) as! SummaryTableViewCell
        
        cell.configureSummaryTableViewCell(summary)
        
        return cell
    }
}
