import UIKit

class SearchGamesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var arrayGames: [Game] = []
    var searchController: UISearchController?
    var searchActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: NibName.gameCellTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameCellTableViewCell)
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.tintColor = UIColor.black
        searchController?.searchBar.delegate = self
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search game..."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = nil
        tabBarController?.navigationItem.titleView = searchController?.searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController?.searchBar.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let searchController = searchController, searchController.isActive {
            searchController.isActive = false
        }
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
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController?.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController?.searchBar.text else { return }
        var textSearchChange = ""
        if searchController?.searchBar.text != nil && textSearchChange != searchText {
            self.arrayGames.removeAll()
            self.tableView.reloadData()
            textSearchChange = searchText
        }
        let activityIndicator = ActivityIndicator(view: self.view)
        activityIndicator.startAnimating()
        let decodedJSON = DecodeJSON(url: getUrlSearchedGames(title: searchText))
        decodedJSON.getSearchGames(weak: { arrayGames in
            if arrayGames.count > 1 {
                self.arrayGames = arrayGames
                activityIndicator.stopAnimating()
                self.tableView.reloadData()
            } else {
                let alert = Alert(title: "Search result for: \(searchText)", message: "Your search returns no result.")
                self.searchController?.present(alert.alertControllerLaunch(), animated: true, completion: nil)
                activityIndicator.stopAnimating()
            }
        })
    }
    
}
