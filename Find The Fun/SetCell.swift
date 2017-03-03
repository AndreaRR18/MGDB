import Foundation
import UIKit

protocol CellFactory {
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController)
}

class GameCell: CellFactory {
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        navigationController.pushViewController(DescriptionViewController(game: game), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameCellTableViewCell, for: indexPath) as! GameCellTableViewCell
        cell.configureGameCell(game)
        return cell
    }
}

