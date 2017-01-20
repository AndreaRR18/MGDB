import UIKit
import Argo
import Curry
import Runes

class GameTableViewController: UITableViewController {
    
    let gamesURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&search=zelda"
    
    
    
    var arrayGames: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCellTableViewCell")
        self.tableView.tableFooterView = UIView()
        self.navigationItem.title = "Find the Fun"
        // inserire qui un activity indicator
        getGame()
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
        return arrayGames[indexPath.row].getCellForTableViewController(tableView: tableView, indexPath: indexPath)!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        arrayGames[indexPath.row].didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController, game: arrayGames[indexPath.row])
    }
    
    func getGame() {
        guard let url = URL(string: gamesURL) else { return }
        let req = NSMutableURLRequest(url: url)
        req.setValue("ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5", forHTTPHeaderField: "X-Mashape-Key")
        let task = URLSession.shared.dataTask(with: req as URLRequest, completionHandler: {
            (data, response, error) -> Void in
            if let data = data {
                self.arrayGames = self.parseJsonData(data: data)
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        })
        task.resume()
    }
    
//    func parseJsonData(data: Data) -> [Game] {
//        var games = [Game]()
//        do {
//            let json: Any? = try JSONSerialization.jsonObject(with: data, options: [])
//            if let j: Any = json {
//                games.append(decode(j)!)
//            }
//        } catch {
//            print(error)
//        }
//        return games
//    }
    
    func parseJsonData(data: Data) -> [Game] {
        var games = [Game]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
            let jsonGames = jsonResult as! [AnyObject]
            for jsonGame in jsonGames {
                let game = Game(
                    idGame: jsonGame["id"] as! Int,
                    name: jsonGame["name"] as! String,
                    summary: jsonGame["summary"] as? String,
                    rating: jsonGame["rating"] as? Int,
                    developers: jsonGame["developers"] as? [Int],
                    releaseDate: nil)
                games.append(game)
            }
        } catch {
            print(error)
        }
        return games
    }
    
//                if let data = data {
//                    let json: Any? = try? JSONSerialization.jsonObject(with: data, options: [])
//                    if let j: Any = json {
//                        guard let decodedJSON: [Game] = decode(j) else { return }
//                        self.arrayGames = decodedJSON
//                        OperationQueue.main.addOperation {
//                            self.tableView.reloadData()
//                        }
//                    }
//                } else {
//                    print("\(error)")
//                }
//            })
//            task.resume()
//    
//        }
}







