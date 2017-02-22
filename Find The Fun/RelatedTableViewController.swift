import UIKit
import Foundation

class RelatedTableViewController: UITableViewController {
    
    var idGenres: [Int]
    var arrayGames: [Game] = []
    var activityIndicatorAppear = true
    
    required init(idGenres: [Int]) {
        self.idGenres = idGenres
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCellTableViewCell")
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
        takeCommonIDGames { commonElement in
            if commonElement.count < 30 {
                commonElement.forEach({ idGame in
                    let decodedJSON = DecodeJSON(url: getUrlIDGame(idGame: idGame))
                    decodedJSON.getGamesFromID(callback: { game in
                        guard game.summary != nil, game.cover != nil else { return }
                        self.arrayGames.append(game)
                    })
                })
            } else {
                commonElement[0...19].forEach({ _ in
                    let decodedJSON = DecodeJSON(url: getUrlIDGame(idGame: commonElement.randomItem()))
                    decodedJSON.getGamesFromID(callback: { game in
                        guard game.summary != nil, game.cover != nil else { return }
                        self.arrayGames.append(game)
                    })
                })
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = "Related Games"
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        let activityIndicator = ActivityIndicator(view: view)
        if activityIndicatorAppear {
            activityIndicatorAppear = false
            activityIndicator.startAnimating()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
            self.tableView.reloadData()
            activityIndicator.stopAnimating()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
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
    
    func takeIdGames(idGenres: [Int], callback: @escaping(_ arrayIDGames: [Int], _ arrayOfArrayIDGames: [[Int]]) -> ()) {
        idGenres.forEach{ genre in
            var arrayOfArrayIDGames: [[Int]] = []
            var arrayIDGames: [Int] = []
            let decodedJSON = DecodeJSON(url: getUrlIDGenres(idGenre: genre))
            decodedJSON.getGenres(callback: { arrayGenre in
                guard let games = arrayGenre.first?.games else { return }
                arrayIDGames += games
                arrayOfArrayIDGames.append(games)
                callback(arrayIDGames, arrayOfArrayIDGames)
            })
        }
    }
    
    func takeCommonIDGames(callback: @escaping(_ commonElement: [Int]) -> ()) {
        takeIdGames(idGenres: self.idGenres, callback: { arrayIDGames, arrayOfArrayIDGames in
            let arraySetIdGames = Set(arrayIDGames)
            let arrayOfArraySetIdGames = arrayOfArrayIDGames.map(Set.init)
            let commonElementSet = arrayOfArraySetIdGames.reduce(arraySetIdGames) { $0.intersection($1) }
            callback(Array(commonElementSet))
        })
        
    }
}



