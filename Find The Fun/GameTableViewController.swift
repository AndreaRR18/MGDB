import UIKit

class GameTableViewController: UITableViewController {
    
    var arrayGames: [Game] = [
        darkSouls,
        theWitcher,
        gtaV,
        noManSky,
        superMarioMaker
    ]
    
    let gameURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*"
    
    
//    init() {
//        super.init(nibName: "GameTableViewController", bundle: nil)
//
//        guard let getGame = URL(string: gameURL) else { return }
//        let request = URLRequest(url: getGame)
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {
//            (data, response, error) -> Void in
//            if let error = error {
//                print(error)
//                return
//            }
//            if let data = data {
//                self.arrayGames = self.parseJson(data: data)
//            }
//        })
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func parseJson(data: Data) -> [Game] {
//        var games: [Game] = []
//        do {
//            let jsonResult = try JSONSerialization.jsonObject(with: data, options:
//                JSONSerialization.ReadingOptions.mutableContainers) as? [Game]
//         
//            for singleGame in jsonResult!
//            {
//                let game = Game(idGame: singleGame["id"] as Int,
//                                name: singleGame["name"] as String,
//                                firstReleaseDate: "",
//                                company: "",
//                                cover: #imageLiteral(resourceName: "darksouls"),
//                                summary: "",
//                                platform: "",
//                                rate: "")
//            
//                games.append(game)
//            }
//        }
//        catch {
//                print("exception")
//                }
//        
//        return games
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCellTableViewCell")
        self.tableView.tableFooterView = UIView()
        self.navigationItem.title = "Find the Fun"
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
    
}
