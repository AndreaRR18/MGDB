import UIKit
import Argo
import Curry
import Runes
import AlamofireImage
import CoreData

class GameTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var offset = 0
    private var arrayGames: [Game] = []
    private var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
    private let cachedGame = CacheGame(
        fileName: "data",
        fileExtension: .JSON,
        subDirectory: "NewGame",
        directory: .applicationSupportDirectory)
    

    
    init() {
        super.init(nibName: "GameTableViewController", bundle: nil)
        let activityIndicator = ActivityIndicator(view: view)
        activityIndicator.startAnimating()
        ProvideArray.newGames{ arrayGames in
            self.arrayGames = arrayGames
            activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        
        let headerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        headerImage.contentMode = .scaleAspectFit
        headerImage.image = UIImage(named: "ufo")
        
        navigationItem.titleView = headerImage
        
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor = ColorUI.navBar
        
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
        
        let footerView = UIView(
            frame: CGRect.init(
                x: 0,
                y: 0,
                width: view.frame.width,
                height: view.frame.height))
        
        footerView.backgroundColor = UIColor.white
        
        tableView.tableFooterView = footerView
        
        checkReachability()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(reachabilityDidChange(_:)),
                name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName),
                object: nil)
        
        _ = reachability?.startNotifier()
        
        
        //        if let reachabilityIsValid = reachability?.isReachable, reachabilityIsValid {
        
        
//        let decodedJSON = DecodeJSON(url: GetUrl.newGamesURL)
//        
//        decodedJSON.getNewGames(callback: { getNewGame in
//            do {
//                let arrayGames = try getNewGame()
//                self.arrayGames = arrayGames
//                activityIndicator.stopAnimating()
//                self.tableView.reloadData()
//            } catch let error {
//                print("\(error)")
//            }
//        })
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGames.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIButton().sendActions(for: .touchUpInside)
        return 140
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return GameCell(game: arrayGames[indexPath.row])
            .getCell(
                tableView: tableView,
                indexPath: indexPath,
                handleError: {_ in })
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        
        GameCell(game: arrayGames[indexPath.row])
            .didSelectCell(
                tableView: tableView,
                indexPath: indexPath,
                navigationController: navController)
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(
            style: UITableViewRowActionStyle.default,
            title: "Share",
            handler: { (action, indexPath) -> Void in
                
                guard let internetPage = self.arrayGames[indexPath.row].internetPage else { return }
                
                let defaultText: String = "Just checking in at " + "m."+internetPage.replacingOccurrences(of: "https://www.", with: "")
                let activityController = UIActivityViewController(
                    activityItems: [defaultText],
                    applicationActivities: nil)
                
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
            let decodedJSON = DecodeJSON(url: GetUrl.getUrlOffsetdGames(offset: offset))
            
            decodedJSON.getNewGames(callback: { getNewGames in
                do {
                    let arrayGames = try getNewGames()
                    self.arrayGames += arrayGames
                    self.tableView.reloadData()
                } catch let error {
                    print("\(error)")
                }
                
            })
        }
    }
    
    
    @objc private func checkReachability() {
        guard let r = reachability  else { return }
        if r.isReachable {
            print("Sono Connesso!")
        } else {
            print("Non sono Connesso!")
        }
    }
    
    
    @objc private func reachabilityDidChange(_ notification: Notification) {
        checkReachability()
    }
    
    
    @objc private func refresh() {
        self.refreshControl?.beginRefreshing()
        
        let decodedJSON = DecodeJSON(url: GetUrl.newGamesURL)
        
        decodedJSON.getNewGames(callback: { getNewGames in
            do {
                let arrayGames = try getNewGames()
                self.arrayGames = arrayGames
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            } catch let error {
                print("\(error)")
            }
                    })
    }
}










