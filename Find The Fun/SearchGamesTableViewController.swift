import UIKit
import Argo

class SearchGamesTableViewController: UITableViewController, UISearchBarDelegate {

        let gamesURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50"
        let apiKey = "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5"
        let httpHeaderField = "X-Mashape-Key"
        var arrayGames: [Game] = []
        
        var searchController: UISearchController!
        
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
            
            tabBarController?.navigationItem.titleView = searchController.searchBar
            
            // inserire qui un activity indicator
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
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            guard let searchText = searchController.searchBar.text else { return }
            guard searchText.characters.count > 3 else { return }
            let decodedJSON = DecodeGameJSON(gamesURL: getUrlSearchedGames(title: searchText), apiKey: apiKey, httpHeaderField: httpHeaderField)
            let urlGame = getUrlSearchedGames(title: searchText)
            print(urlGame)
            decodedJSON.getGames(callback: { arrayGames in
                self.arrayGames = arrayGames
                self.tableView.reloadData()
                
            })
        }
    
    }
