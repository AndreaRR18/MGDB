import UIKit
import Argo
import Curry
import Runes
import AlamofireImage
import CoreData

class GameTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var offset = 0
    let gamesURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=30&order=updated_at%3Adesc"
    let apiKey = "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5"
    let httpHeaderField = "X-Mashape-Key"
    var arrayGames: [Game] = []
    let logo = UIImageView()
    
    var activityIndicatorAppeared = true
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var activityIndicatorFooter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var viewActivityIndicatorFooter = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCellTableViewCell")

        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
        let decodedJSON = DecodeJSON(url: gamesURL, apiKey: apiKey, httpHeaderField: httpHeaderField)
        decodedJSON.getNewGames(callback: { arrayGames in
            self.arrayGames = arrayGames
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        })
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.allEvents)
        refreshControl?.tintColor = UIColor.white
        logo.image = #imageLiteral(resourceName: "ufo")
        tabBarController?.navigationItem.titleView?.addSubview(logo) 
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let navBarImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        navBarImageView.contentMode = .scaleAspectFit
        
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
        
        
        
        if activityIndicatorAppeared {
            activityIndicatorAppeared = false
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
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
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return arrayGames[indexPath.row].getCellForTableViewController(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        arrayGames[indexPath.row].didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController, game: arrayGames[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
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
            offset += 10
            let decodedJSON = DecodeJSON(url: getUrlOffsetdGames(offset: offset), apiKey: apiKey, httpHeaderField: httpHeaderField)
            decodedJSON.getNewGames(callback: { arrayGames in
                self.arrayGames += arrayGames
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    func refresh() {
        self.refreshControl?.beginRefreshing()
        let decodedJSON = DecodeJSON(url: gamesURL, apiKey: apiKey, httpHeaderField: httpHeaderField)
        decodedJSON.getNewGames(callback: { arrayGames in
            self.arrayGames = arrayGames
            self.activityIndicator.stopAnimating()
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
}









