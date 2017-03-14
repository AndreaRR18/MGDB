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
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
        
        GameModeCoreData.nameGameModeDB(
            id: gameMode,
            callback: { nameGameModes in
            
                cell.configureGameModesTableViewCell(nameGameModes)
        
        })
        
        return cell
    
    }

}
