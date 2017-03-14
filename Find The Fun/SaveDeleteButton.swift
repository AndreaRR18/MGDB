import Foundation
import UIKit
import AlamofireImage
import CoreData

struct SaveDeleteButton {
    
    let url: URL
    
    let gameDescription: Game
    
    let idCompany: Int
    
    let saveFavourite = UIButton(type: .custom)
    
    let removeFavourite = UIButton(type: .custom)
    
    let view: UIView
    
    let tableViewController: UITableViewController
    
    init(url: URL, gameDescription: Game, idCompany: Int, view: UIView, tableViewController: UITableViewController) {
    
        self.url = url
        
        self.gameDescription = gameDescription
        
        self.idCompany = idCompany
        
        self.view = view
        
        self.tableViewController = tableViewController
    
    }
    
    
    func save() -> UIBarButtonItem {
    
        saveFavourite.setTitle(
            "Save",
            for: .normal)
        
        saveFavourite.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        
        return UIBarButtonItem(customView: saveFavourite)
        
    }
    
    
    func delete() -> UIBarButtonItem {
    
        removeFavourite.setTitle(
            "Remove",
            for: .normal)
        
        removeFavourite.frame = CGRect(
            x: 0,
            y: 0,
            width: 80,
            height: 30)
        
        return UIBarButtonItem(customView: removeFavourite)
    
    }
    
    
    func saveFavourite(sender: UIButton) {
    
        let activityIndicator = ActivityIndicator(view: view)
        
        activityIndicator.startAnimating()
        
        sender.setTitle(
            "Added",
            for: .normal)
        
        sender.isEnabled = false
        
        let cover = UIImageView()
        
        cover.af_setImage(withURL: url,
                          placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                          filter: nil,
                          progress: nil,
                          progressQueue: DispatchQueue.main,
                          imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
                          runImageTransitionIfCached: true,
                          completion: { _ in
        
                            saveFavouriteGame(
                            
                                game: self.gameDescription,
                                
                                image: cover.image)
                            
                            activityIndicator.stopAnimating()
                            
        })
        
    }
    
    
    func removeFavourite(sender: UIButton) {
    
        sender.isEnabled = false
        
        sender.setTitle(
            "Removed",
            for: .normal)
        
        deleteFavouriteGame(id: Int32(gameDescription.idGame))
    }
}
