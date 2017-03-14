import Foundation
import UIKit

class ScreenshotCell: CellFactory, ScreenshotDelegate {
    
    private let screenshots: [Screenshot]?
    
    private let navigationController: UINavigationController?
    
    
    init(screenshots: [Screenshot]?, navigationController: UINavigationController?) {
        
        self.screenshots = screenshots
        
        self.navigationController = navigationController
   
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.screenshotsCollectionTableViewCell, for: indexPath) as! ScreenshotCollectionTableViewCell
        
        if screenshots == nil || screenshots?.count == 0 { cell.screenshotLabel?.text = "" }
        
        guard let screenshots = screenshots else { return cell }
        
        if screenshots.count == 0 { cell.screenshotLabel?.text = "" }
        
        cell.configureScreenshotCollectionTableViewCell(screenshots)
        
        cell.delegate = self
        
        return cell
    
    }
    
    
    func openImage(url: String) {
        
        guard let navController = navigationController else { return }
        
        navController.present(
            CoverViewController(coverURL: url),
            animated: true,
            completion: nil)
    
    }
    
}

