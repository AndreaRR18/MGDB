import UIKit
import Foundation

class RelatedTableViewController: UITableViewController {
    
    private var idGenres: [Int]
    private var arrayGames: [Game] = []
    private var activityIndicatorAppear = true
    
    
    required init(idGenres: [Int]) {
        self.idGenres = idGenres
        super.init(style: .plain)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(
            UINib(nibName: NibName.gameCellTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.gameCellTableViewCell)
        
        let viewFooter = UIView()
        
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        
        self.tableView.tableFooterView = viewFooter
        
        self.view.backgroundColor = ColorUI.backgoundTableView
        
        let activityIndicator = ActivityIndicator(view: view)
        if activityIndicatorAppear {
            activityIndicatorAppear = false
            activityIndicator.startAnimating()
        }
        
        takeCommonIDGames { getElement in
            do {
                let commonElement = try getElement()
                let idGames = commonElement
                    .map(String.init)
                    .joined(separator: ",")
                let decodedJSON = DecodeJSON(url: GetUrl.getUrlIDGame(idGame: idGames))
                
                decodedJSON.getNewGames(
                    callback: {getNewGames in
                        do {
                            let games = try getNewGames()
                            self.arrayGames = games.filter { $0.rating ?? 0 > 0 }
                            self.tableView.reloadData()
                            activityIndicator.stopAnimating()
                        } catch let error {
                            print("\(error)")
                        }
                })
            } catch let error {
                print("\(error)")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationItem.title = "Related Games"
        
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
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        
        GameCell(game: arrayGames[indexPath.row])
            .didSelectCell(
                tableView: tableView,
                indexPath: indexPath,
                navigationController: navController)
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    }
    
    
    func takeIdGames(idGenres: [Int], idGame callback: @escaping (() throws -> (arrayIDGames: [Int], arrayOfArrayIDGames: [[Int]])) -> ()) {
        
        idGenres.forEach{ genre in
            
            var arrayOfArrayIDGames: [[Int]] = []
            var arrayIDGames: [Int] = []
            let decodedJSON = DecodeJSON(url: GetUrl.getUrlIDGenres(idGenre: genre))
            
            decodedJSON.getGenres( callback: { getGenre in
                do {
                    let arrayGenre = try getGenre()
                    
                    guard let games = arrayGenre.first?.games else { return }
                    arrayIDGames += games
                    arrayOfArrayIDGames.append(games)
                    callback { (arrayIDGames, arrayOfArrayIDGames) }
                    
                } catch let error {
                    callback { throw error }
                }
            })
        }
    }
    
    
    func takeCommonIDGames(callback: @escaping(() throws -> ([Int])) -> ()) {
        takeIdGames(idGenres: self.idGenres, idGame: { getTuple in
            do {
                let (arrayIDGames, arrayOfArrayIDGames) = try getTuple()
                let arraySetIdGames = Set(arrayIDGames)
                let arrayOfArraySetIdGames = arrayOfArrayIDGames.map(Set.init)
                let commonElementSet = arrayOfArraySetIdGames.reduce(arraySetIdGames) { $0.intersection($1) }
                
                if commonElementSet.count > 100 {
                    let arrayInt = Array(commonElementSet)<->
                    let slice: [Int] = Array(arrayInt[0..<100])
                    callback { slice }
                } else {
                    callback { Array(commonElementSet) }
                }
                
            } catch let error {
                print("\(error)")
            }
            
        })
    }
}
