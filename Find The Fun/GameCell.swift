import Foundation
import UIKit

class GameCell: CellFactory {
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        navigationController.pushViewController(
            DescriptionViewController(game: game),
            animated: true)
        
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: GameCellTableViewCell.cellIdentifier) as? GameCellTableViewCell) ?? GameCellTableViewCell.fromXIB
        cell.configureGameCell(game)
        return cell
    }
}

