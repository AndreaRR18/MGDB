import UIKit
import Argo

class SearchGamesTableViewController: UITableViewController, UISearchBarDelegate {
    
    let gamesURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50"
    let apiKey = "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5"
    let httpHeaderField = "X-Mashape-Key"
    var arrayGames: [Game] = []
    
    
    var searchController: UISearchController!
    var searchActive = true

    var activityIndicatorAppeared = false
    var emptyArray: [Game] = []
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCellTableViewCell")
        self.tableView.tableFooterView = UIView()
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.navigationController?.navigationBar.isTranslucent = false
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search game..."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = nil
        tabBarController?.navigationItem.titleView = searchController.searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController.searchBar.becomeFirstResponder()
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
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text else { return }
        
        var textSearchChange = ""
        if searchController.searchBar.text != nil && textSearchChange != searchText{
            self.arrayGames.removeAll()
            self.tableView.reloadData()
            textSearchChange = searchText
        }
        activityIndicatorAppeared = false
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        
        let decodedJSON = DecodeJSON(url: getUrlSearchedGames(title: searchText), apiKey: apiKey, httpHeaderField: httpHeaderField)
        decodedJSON.getSearchGames(weak: { arrayGames in
            self.arrayGames = arrayGames
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        })
    }
    
}
