import UIKit
import Argo
import Curry
import Runes
import AlamofireImage
import CoreData

class GameTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var offset = 0
    let gamesURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&order=updated_at%3Adesc"
    var arrayGames: [Game] = []
    var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
    let cachedGame = CacheGame(fileName: "data", fileExtension: .JSON, subDirectory: "NewGame", directory: .applicationSupportDirectory)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: NibName.gameCellTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameCellTableViewCell)
        
        let activityIndicator = ActivityIndicator(view: view)
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
        _ = reachability?.startNotifier()
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
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
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability?.stopNotifier()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
        let navBarImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        navBarImageView.contentMode = .scaleAspectFit
        checkReachability()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "homeIcon 35x35"))
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
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return arrayGames[indexPath.row].getCellForTableViewController(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        arrayGames[indexPath.row].didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController, game: arrayGames[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
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
            let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: Int(view.frame.width), height: 30))
            footerView.backgroundColor = UIColor.white
            
            let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            footerView.addSubview(activityView)
            activityView.startAnimating()
            
            activityView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint(
                item: activityView,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: footerView,
                attribute: .centerX,
                multiplier: 1.0,
                constant: 0.0
                ).isActive = true
            
            NSLayoutConstraint(
                item: activityView,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: footerView,
                attribute: .centerY,
                multiplier: 1.0,
                constant: 0.0
                ).isActive = true
            self.tableView.tableFooterView = footerView
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
            print("Oops, mi dispiace ma non ce la faccio!")
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
    
    

}










