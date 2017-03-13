import UIKit
import Argo
import Curry
import Runes
import AlamofireImage
import CoreData

class GameTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var offset = 0
    let gamesURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&order=updated_at%3Adesc&filter[aggregated_rating][gt]=1"
    var arrayGames: [Game] = []
    var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
    let cachedGame = CacheGame(fileName: "data", fileExtension: .JSON, subDirectory: "NewGame", directory: .applicationSupportDirectory)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: NibName.gameCellTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameCellTableViewCell)
        
        let activityIndicator = ActivityIndicator(view: view)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
        
        _ = reachability?.startNotifier()
        
//        if let reachabilityIsValid = reachability?.isReachable, reachabilityIsValid {
            activityIndicator.startAnimating()
            let decodedJSON = DecodeJSON(url: gamesURL)
            decodedJSON.getNewGames(callback: { arrayGames in
                self.arrayGames = arrayGames
                activityIndicator.stopAnimating()
                self.tableView.reloadData()
                
            })
//        }else {
//            do {
//                try self.arrayGames = cachedGame.getJSONData() ?? []
//                self.tableView.reloadData()
//            } catch {
//                print(error)
//            }
//        }
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.allEvents)
        refreshControl?.tintColor = UIColor.gray
        
        navigationController?.toolbar.isHidden = false

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability?.stopNotifier()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        
        
        let headerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        headerImage.contentMode = .scaleAspectFit
        headerImage.image = UIImage(named: "prova-esagono-play-def")
        navigationItem.titleView = headerImage
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor = ColorUI.navBar
        
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
        
        let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        footerView.backgroundColor = UIColor.white
        tableView.tableFooterView = footerView
        
        
        checkReachability()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGames.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = GameCell(game: arrayGames[indexPath.row])
        return game.getCell(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        GameCell(game: arrayGames[indexPath.row]).didSelectCell(tableView: tableView, indexPath: indexPath, navigationController: navController)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in
            guard let page = self.arrayGames[indexPath.row].internetPage else { return }
            let defaultText: Any = "Just checking in at " + "m."+page.replacingOccurrences(of: "https://www.", with: "")
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
        shareAction.backgroundColor = UIColor.gray
        return [shareAction]
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > arrayGames.count - 5 {
            self.tableView.tableFooterView = ActivityIndicator.activityIndicatorFooterView(view)
        }
        if indexPath.row == arrayGames.count - 5 {
            offset += 30
            let decodedJSON = DecodeJSON(url: getUrlOffsetdGames(offset: offset))
            decodedJSON.getNewGames(callback: { arrayGames in
                self.arrayGames += arrayGames
                self.tableView.reloadData()
            })
        }
    }
    
    func checkReachability() {
        guard let r = reachability  else { return }
        if r.isReachable {
            print("Sono Connesso!")
        } else {
            print("Non sono Connesso!")
        }
    }
    
    func reachabilityDidChange(_ notification: Notification) {
        checkReachability()
    }
    
    func refresh() {
        self.refreshControl?.beginRefreshing()
        let decodedJSON = DecodeJSON(url: gamesURL)
        decodedJSON.getNewGames(callback: { arrayGames in
            self.arrayGames = arrayGames
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    func pushInfoPage() {
        navigationController?.pushViewController(About(), animated: true)
    }
}










