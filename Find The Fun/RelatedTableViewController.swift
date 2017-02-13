import UIKit
import Foundation

class RelatedTableViewController: UITableViewController {
    
    var idGenres: [Int]
    var arrayGames: [Game] = []
    var arrayIDGames: [Int] = []
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = "Related Games"
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        let activityIndicator = ActivityIndicator(view: view)
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.tableView.reloadData()
            activityIndicator.stopAnimating()
        })

            idGenres.forEach{ genre in
                let decodedJSON = DecodeJSON(url: getUrlIDGenres(idGenre: genre))
                decodedJSON.getGenres(callback: { arrayGenre in
                    print(arrayGenre)
//                    self.arrayIDGames += arrayGenre.first!.games
//                    let array = Set(self.arrayIDGames)
//                    let set2 = array8.reduce(set1) { $0.intersection($1) }
//                    let array10 = Array(set2)
//                    self.refreshControl?.endRefreshing()
//                    self.tableView.reloadData()
                })
            }
            

//        }
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
        return arrayGames[indexPath.row].getCellForTableViewController(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let navController = navigationController else { return }
//        arrayGames[indexPath.row].didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController, game: arrayIDGames[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}



