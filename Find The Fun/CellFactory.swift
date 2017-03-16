import UIKit

protocol CellFactory {
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController)
}
