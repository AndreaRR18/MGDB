import Foundation
import UIKit

class GameModeCell: CellFactory {
    
    private let gameMode: [Int]
    
    init(_ gameMode: [Int]) {
        self.gameMode = gameMode
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    }
    
//    static func getCellHeight(for values: [Int]?) -> CGFloat {
//        guard gameMode != nil else { return 0 }
//        return 50
//    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
        
        GameModeCoreData.nameGameModeDB(
            id: gameMode,
            callback: { getGameModes in
                do {
                    let nameGameModes = try getGameModes()
                    cell.configureGameModesTableViewCell(nameGameModes)
                } catch let error {
                    handleError(error)
                }
        })
        
        return cell
    }
}
