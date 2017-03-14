import UIKit
import CoreData
import Foundation

class SearchGamesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var arrayGames: [Game] = []
    
    let searchBar = UISearchBar()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == true {
            
            navigationController?.setNavigationBarHidden(false, animated: animated)
            
        }
        
        navigationController?.navigationBar.barTintColor = ColorUI.navBar
        
        tabBarController?.tabBar.isTranslucent = false
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: NibName.gameCellTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameCellTableViewCell)
        
        let tableViewController = UITableViewController(style: .plain)
        
        tableViewController.tableView.dataSource = self
        
        tableViewController.tableView.delegate = self
        
        tableViewController.tableView.register(
            UINib(nibName: NibName.gameCellTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.gameCellTableViewCell)
        
        searchBar.showsCancelButton = true
        
        searchBar.placeholder = "Search game..."
        
        searchBar.delegate = self
        
        searchBar.barTintColor = UIColor.white
        
        navigationItem.titleView = searchBar
        
        definesPresentationContext = true
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        searchBar.becomeFirstResponder()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        searchBar.endEditing(true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayGames.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameCellTableViewCell, for: indexPath) as! GameCellTableViewCell
        
        cell.configureGameCell(arrayGames[indexPath.row])
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let navController = navigationController else { return }
        
        GameCell( game: arrayGames[indexPath.row]).didSelectCell(
            tableView: tableView,
            indexPath: indexPath,
            navigationController: navController)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        searchBar.endEditing(true)
        
    }
    
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        
    }
    
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        
        var textSearchChange = ""
        
        if searchBar.text != nil && textSearchChange != searchText {
            
            self.arrayGames.removeAll()
            
            self.tableView.reloadData()
            
            textSearchChange = searchText
            
        }
        
        let activityIndicator = ActivityIndicator(view: self.view)
        
        activityIndicator.startAnimating()
        
        let decodedJSON = DecodeJSON(url: GetUrl.getUrlSearchedGames(title: searchText))
        
        decodedJSON.getSearchGames(weak: { arrayGames in
            
            if arrayGames.count > 1 {
                
                self.arrayGames = arrayGames.filter{ game in
                    
                    game.name
                        .replacingOccurrences(of: " ", with: "")
                        .lowercased()
                        .contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())
                    
                    
                    }
                    .sorted(by: { (a, b) -> Bool in
                        a.rating ?? 1 > b.rating ?? 1
                    })
                
                activityIndicator.stopAnimating()
                
                self.tableView.reloadData()
                
            } else {
                
                let alert = Alert(
                    title: "Search result for: \(searchText)",
                    message: "Your search returns no result.")
                
                self.present(
                    alert.alertControllerLaunch(),
                    animated: true,
                    completion: nil)
                
                activityIndicator.stopAnimating()
                
            }
            
        })
        
    }
    
}
