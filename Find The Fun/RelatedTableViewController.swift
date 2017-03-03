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
        self.tableView.register(UINib(nibName: NibName.gameCellTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameCellTableViewCell)
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
        
        let activityIndicator = ActivityIndicator(view: view)
        if activityIndicatorAppear {
            activityIndicatorAppear = false
            activityIndicator.startAnimating()
        }
        takeCommonIDGames { commonElement in
            let idGames = commonElement
                .map(String.init)
                .joined(separator: ",")
            let decodedJSON = DecodeJSON(url: getUrlIDGame(idGame: idGames))
            decodedJSON.getNewGames(callback: {games in
                self.arrayGames = games.filter { $0.rating ?? 0 > 0 }
                self.tableView.reloadData()
                activityIndicator.stopAnimating()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }

        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        navigationItem.title = "Related Games"
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
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
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameCellTableViewCell, for: indexPath) as! GameCellTableViewCell
        cell.configureGameCell(arrayGames[indexPath.row])
        return cell

//        return arrayGames[indexPath.row].getCellForTableViewController(tableView: tableView, indexPath: indexPath)
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
            if commonElementSet.count > 100 {                
                let arrayInt = Array(commonElementSet)<->
                let slice: [Int] = Array(arrayInt[0..<100])
                callback(slice)
            } else {
                callback(Array(commonElementSet))
            }
        })
    }
}








