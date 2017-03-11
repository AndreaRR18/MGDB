import UIKit

protocol CellFactory {
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController)
}
