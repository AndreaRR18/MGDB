import UIKit
import Argo
import Curry
import Runes
import AlamofireImage

class GameTableViewController: UITableViewController {
    
    let gamesURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&order=first_release_date%3Adesc"
    let apiKey = "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5"
    let httpHeaderField = "X-Mashape-Key"
    var arrayGames: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCellTableViewCell")
        self.tableView.tableFooterView = UIView()
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.navigationController?.navigationBar.isTranslucent = false
        tabBarController?.navigationController?.navigationItem.title = "FTF"
        let decodedJSON = DecodeGameJSON(gamesURL: gamesURL, apiKey: apiKey, httpHeaderField: httpHeaderField)
        
        decodedJSON.getGames(callback: { arrayGames in
            self.arrayGames = arrayGames
            self.tableView.reloadData()
        })
        
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

}







