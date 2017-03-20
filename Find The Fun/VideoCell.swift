import Foundation
import UIKit
import SafariServices

class VideoCell: CellFactory, VideoDelegate {
    
    private let video: [Video]?
    private let navigationController: UINavigationController?
    
    
    init(video: [Video]?, navigationController: UINavigationController?) {
        self.video = video
        self.navigationController = navigationController
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: VideoCollectionTableViewCell.cellIdentifier) as? VideoCollectionTableViewCell) ?? VideoCollectionTableViewCell.fromXIB
        
        guard let video = video else { return cell }
        
        cell.configureVideoCollectionTableViewCell(video)
        cell.delegate = self
        
        return cell
    }
    
    
    func openSafariView(_ url: URL) {
        guard let navigationController = navigationController else { return }
        
        let safariVC = SFSafariViewController(url: url)
        
        navigationController.present(
            safariVC,
            animated: true,
            completion: nil)
    }
}
