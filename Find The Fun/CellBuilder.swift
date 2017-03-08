import Foundation
import UIKit

//------------Cell Builder-------------

extension Game {
    
    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, game: Game) {
        navigationController.pushViewController(DescriptionViewController(game: game), animated: true)
    }

    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        switch indexPath.row {
        case 1:
            navigationController.present(CoverViewController(coverURL: cover?.url), animated: true, completion: nil)
        case 9:
            navigationController.navigationBar.isTranslucent = false
            if let genres = genres {
                navigationController.pushViewController(RelatedTableViewController(idGenres: genres), animated: true)
            } else {
                let alert = Alert(title: "Sorry", message: "Related games not found!")
                navigationController.present(alert.alertControllerLaunch(), animated: true, completion: nil)
            }
        default:
            return
        }
    }
}


