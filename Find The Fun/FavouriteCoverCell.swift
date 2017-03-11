import Foundation
import UIKit

class FavouriteCoverCell: CellFactory, ShareDelegate, FavouriteDelegate {
    private let name: String?
    private let cover: UIImage?
    private let rating: Int?
    private let internetPage: String?
    private let navController: UINavigationController?
    private let tableView: UITableView?
    
    init(name: String?, cover: UIImage?, rating: Int?, internetPage: String?, navController: UINavigationController?, tableView: UITableView?) {
        self.name = name
        self.cover = cover
        self.rating = rating
        self.internetPage = internetPage
        self.navController = navController
        self.tableView = tableView
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
        cell.configureFavouriteCoverTableViewCell(name, cover, rating)
        cell.favouriteDelegate = self
        cell.shareDelegate = self
        return cell
    }
    
    func saveGame(game: Game?) {
        guard let game = game else { return }
        let cover = UIImageView()
        let activityIndicator = ActivityIndicator(view: self.tableView!, background: .clear, activityIndicatorColor: .darkGray)
        activityIndicator.startAnimating()
        cover.af_setImage(
            withURL: getCover(url: game.cover?.url)!,
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
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete \(game.name)", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            deleteFavouriteGame(id: Int32(game.idGame))
            self.tableView?.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name("ChangeFavouriteGame"), object: nil)
        }
        alertController.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        navController?.present(alertController, animated: true, completion: nil)
    }
    
    func shareGame() {
        let firstActivityItem = "Look this game:"
        let secondActivityItem : NSURL = NSURL(string: internetPage!)!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
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
        navController?.present(activityViewController, animated: true, completion: nil)
    }
}
