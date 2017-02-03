import UIKit

class RelatedTableViewController: UITableViewController {
    
    var arrayIDGames: [Game] = []
    var arrayIDGenres: [Int] = []
    var idGenres: [Int]?
    var activityIndicatorAppeared = true
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var activityIndicatorFooter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var viewActivityIndicatorFooter = UIView()
    
    
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
        
        guard let idGenre = idGenres?.count else { return }
        for i in 0..<idGenre {
            guard let idGenres = idGenres else { return }
            let decodedJSON = DecodeJSON(url: getUrlIDGenres(idGenre: idGenres[i]))
            decodedJSON.getGenres(callback: { genres in
//                    for i in 0..<20 {
//                            genres[i].games?.forEach{ idGame in
//                            let decodedJSON = DecodeJSON(url: getUrlIDGame(idGame: idGame))
//                            decodedJSON.getRelatedGamesFromID(callback: { game in
//                                guard self.arrayIDGames.count < 20 else { return }
//                                self.arrayIDGames = game
//                            })
//                        }
//
//                    }
                
                genres.forEach{ genre in
                    genre.games?.forEach{ idGame in
                        let decodedJSON = DecodeJSON(url: getUrlIDGame(idGame: idGame))
                        decodedJSON.getRelatedGamesFromID(callback: { game in
                            guard self.arrayIDGames.count < 20 else { return }
                            self.arrayIDGames = game
                            self.activityIndicator.stopAnimating()
                            self.tableView.reloadData()
                        })
                    }
                }
            })
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            self.activityIndicator.stopAnimating()
//            self.tableView.reloadData()
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = "Related Games"
        
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
        
        if activityIndicatorAppeared {
            activityIndicatorAppeared = false
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayIDGames.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return arrayIDGames[indexPath.row].getCellForTableViewController(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        arrayIDGames[indexPath.row].didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController, game: arrayIDGames[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}
