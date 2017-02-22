import UIKit

let offset_HeaderStop: CGFloat = 40.0
let offset_B_LabelHeader: CGFloat = 95.0
let distance_W_LabelHeader: CGFloat = 35.0


class GameDescriptionTableViewController: UITableViewController {
    
    var gameDescription: Game
//    let referenceCoverImage = UIImageView()
//    var coverReference = UIImageView()
//    var headerReference = UIImageView()
//    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CoverHDTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverHDTableViewCell")
        self.tableView.register(UINib(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverTableViewCell")
        self.tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
        self.tableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableViewCell")
        self.tableView.register(UINib(nibName: "PublishedTableViewCell", bundle: nil), forCellReuseIdentifier: "PublishedTableViewCell")
        self.tableView.register(UINib(nibName: "PlatformTableViewCell", bundle: nil), forCellReuseIdentifier: "PlatformTableViewCell")
        self.tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        self.tableView.register(UINib(nibName: "ScreenshotsTableViewCell", bundle: nil), forCellReuseIdentifier: "ScreenshotsTableViewCell")
//        self.tableView.register(UINib(nibName: "ScreenshotCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "ScreenshotCollectionTableViewCell")
        self.tableView.register(UINib(nibName: "GenreTableViewCell", bundle: nil), forCellReuseIdentifier: "GenreTableViewCell")
        self.tableView.register(UINib(nibName: "GameModesTableViewCell", bundle: nil), forCellReuseIdentifier: "GameModesTableViewCell")
        self.tableView.register(UINib(nibName: "RelatedInDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "RelatedInDescriptionTableViewCell")
        self.tableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "VideosTableViewCell")
        
        tableView.delegate = self
        
        let saveFavourite = UIButton(type: .custom)
        saveFavourite.setTitle("Save", for: .normal)
        saveFavourite.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        saveFavourite.addTarget(self, action: #selector(GameDescriptionTableViewController.saveFavourite), for: .touchUpInside)
        let saveGame = UIBarButtonItem(customView: saveFavourite)
        
        let removeFavourite = UIButton(type: .custom)
        removeFavourite.setTitle("Remove", for: .normal)
        removeFavourite.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        removeFavourite.addTarget(self, action: #selector(GameDescriptionTableViewController.removeFavourite), for: .touchUpInside)
        let removeGame = UIBarButtonItem(customView: removeFavourite)
        
        if fetchGameFavourite(id: Int32(gameDescription.idGame)) {
            navigationItem.rightBarButtonItem = saveGame
        } else {
            navigationItem.rightBarButtonItem = removeGame
        }
        title = gameDescription.name
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        
        view.backgroundColor = ColorUI.backgoundTableView
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
    }

    
    required init(game: Game) {
        self.gameDescription = game
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDescription.gameDescriptionFields.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowInGameDescription(indexPath: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if CoverTableViewCell() >!< gameDescription.gameDescriptionFields[indexPath.row](tableView, indexPath) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: CoverTableViewCell.coverTableViewCellIdentifier, for: indexPath) as! CoverTableViewCell
//            coverReference = cell.thumbnail!
//        } else if CoverHDTableViewCell() >!< gameDescription.gameDescriptionFields[indexPath.row](tableView, indexPath) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: CoverHDTableViewCell.coverHDTableViewCellIdentifier, for: indexPath) as! CoverHDTableViewCell
//            headerReference = cell.coverHQ!
//        }
        return gameDescription.gameDescriptionFields[indexPath.row](tableView, indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        gameDescription.didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveFavourite(sender: UIButton) {
        sender.setTitle("Added", for: .normal)
        sender.isEnabled = false
        let cover = UIImageView()
        cover.af_setImage(
            withURL: getCover(url: gameDescription.cover?.url)!,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                saveFavouriteGame(
                    game: self.gameDescription,
                    company: (self.gameDescription.developers?.first)!,
                    image: cover.image!)
        })
    }
    
    func removeFavourite(sender: UIButton) {
        sender.isEnabled = false
        sender.setTitle("Removed", for: .normal)
        deleteFavouriteGame(id: Int32(gameDescription.idGame))
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = tableView.contentOffset.y
//        var headerTrasform = CATransform3DIdentity
//        var coverTrasform = CATransform3DIdentity
//        if offset < 0 {
//            let headerScaleFactor: CGFloat = -(offset) / coverReference.bounds.height
//            let headerSizeVariation = ((coverReference.bounds.height * (1.0 + headerScaleFactor)) - coverReference.bounds.height) / 2.0
//            headerTrasform = CATransform3DTranslate(headerTrasform, 0, headerSizeVariation, 0)
//            headerTrasform = CATransform3DScale(headerTrasform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
//            coverReference.layer.transform = headerTrasform
//        } else {
//            headerTrasform = CATransform3DTranslate(headerTrasform, 0, max(-offset_HeaderStop, -offset), 0)
//            
//            let coverScaleFactor = (min(offset_HeaderStop, offset)) / coverReference.bounds.height / 1.4
//            let coverSizeVariation = ((coverReference.bounds.height * (1.0 + coverScaleFactor)) - coverReference.bounds.height) / 2.0
//            coverTrasform = CATransform3DTranslate(coverTrasform, 0, coverSizeVariation, 0)
//            coverTrasform = CATransform3DScale(coverTrasform, 1.0 - coverScaleFactor, 1.0 - coverScaleFactor, 0)
//        }
//        coverReference.layer.transform = coverTrasform
//        headerReference.layer.transform = headerTrasform
//    }
    
  
    
}
//
//infix operator >!<
//func >!<(object1: AnyObject!, object2: AnyObject!) -> Bool {
//    return (object_getClass(object1) == object_getClass(object2))
//}

