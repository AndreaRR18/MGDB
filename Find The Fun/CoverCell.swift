import Foundation
import UIKit

class CoverCell: CellFactory, ShareDelegate, FavouriteDelegate, ShowCoverDelegate {
    
    private let game: Game?
    
    private let navController: UINavigationController?
    
    private let tableView: UITableView?
    
    init(_ game: Game?, _ navController: UINavigationController?, _ tableView: UITableView?) {
        
        self.game = game
        
        self.navController = navController
        
        self.tableView = tableView
    
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
        
        cell.configureCoverTableViewCell(game)
        
        cell.favouriteDelegate = self
        
        cell.shareDelegate = self
        
        cell.showCoverDelegate = self
        
        return cell
    
    }
    
    
    func saveGame(game: Game?) {
        
        guard let game = game, let url = GetUrl.getCover(url: game.cover?.url ?? "") else { return }
        
        let cover = UIImageView()
        
        let activityIndicator = ActivityIndicator(
            view: self.tableView,
            background: .clear,
            activityIndicatorColor: .white,
            withBackground: true)
        
        activityIndicator.startAnimating()
        
        cover.af_setImage(
            withURL: url,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
        
                guard let cover = cover.image else { return }
                
                saveFavouriteGame(
                    game: game,
                    image: cover)
                
                activityIndicator.stopAnimating()
                
                self.tableView?.reloadData()
                
                NotificationCenter.default.post(name: NSNotification.Name("ChangeFavouriteGame"), object: nil)
        
        })
    
    }
    
    
    func removeGame(game: Game?) {
        
        guard let game = game else { return }
        
        let alertController = UIAlertController(
            title: nil,
            message: "Are you sure you want to delete \(game.name)",
            preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(
        title: "Delete",
        style: .destructive)
        { _ in
            
            deleteFavouriteGame(id: Int32(game.idGame))
            
            self.tableView?.reloadData()
            
            NotificationCenter.default.post(
                name: NSNotification.Name("ChangeFavouriteGame"),
                object: nil)
        
        }
        
        alertController.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel)
        
        alertController.addAction(cancelAction)
        
        navController?.present(
            alertController,
            animated: true,
            completion: nil)
    
    }
    
    
    func shareGame() {
        
        let firstActivityItem = "Look this game:"
        
        guard let internetPage = game?.internetPage, let nsUrl = NSURL(string: internetPage) else { return }
        
        let secondActivityItem : NSURL = nsUrl
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem],
            applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.permittedArrowDirections = .unknown
        
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        activityViewController.excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        
        navController?.present(
            activityViewController,
            animated: true,
            completion: nil)
    
    }
    
    
    func showCover() {
        
        guard let url = game?.cover?.url else { return }
        
        navController?.present(
            CoverViewController(coverURL: url),
            animated: true,
            completion: nil)
    
    }
    
}
