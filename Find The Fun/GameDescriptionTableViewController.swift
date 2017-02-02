import UIKit

class GameDescriptionTableViewController: UITableViewController {
    
    var gameDescription: Game
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverTableViewCell")
        self.tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
        self.tableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableViewCell")
        self.tableView.register(UINib(nibName: "PublishedTableViewCell", bundle: nil), forCellReuseIdentifier: "PublishedTableViewCell")
        self.tableView.register(UINib(nibName: "PlatformTableViewCell", bundle: nil), forCellReuseIdentifier: "PlatformTableViewCell")
        self.tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        self.tableView.register(UINib(nibName: "ScreenshotsTableViewCell", bundle: nil), forCellReuseIdentifier: "ScreenshotsTableViewCell")
        self.tableView.register(UINib(nibName: "GenreTableViewCell", bundle: nil), forCellReuseIdentifier: "GenreTableViewCell")
        self.tableView.register(UINib(nibName: "GameModesTableViewCell", bundle: nil), forCellReuseIdentifier: "GameModesTableViewCell")

        
        let saveFavourite = UIButton(type: .custom)
        saveFavourite.setTitle("Save", for: .normal)
        saveFavourite.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        saveFavourite.addTarget(self, action: #selector(GameDescriptionTableViewController.saveFavourite), for: .touchUpInside)
        let saveGame = UIBarButtonItem(customView: saveFavourite)
        
        let removeFavourite = UIButton(type: .custom)
        removeFavourite.setTitle("Remove", for: .normal)
        removeFavourite.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        removeFavourite.addTarget(self, action: #selector(GameDescriptionTableViewController.removeFavourite), for: .touchUpInside)
        let removeGame = UIBarButtonItem(customView: removeFavourite)
        
        if fetchGameFavourite(id: Int32(gameDescription.idGame)) {
            navigationItem.rightBarButtonItem = saveGame
        } else {
            navigationItem.rightBarButtonItem = removeGame
        }
        title = gameDescription.name
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        
        let backItem = UIBarButtonItem()
        backItem.title = nil
        tabBarController?.navigationItem.backBarButtonItem = backItem
        
        view.backgroundColor = ColorUI.backgoundTableView
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
        
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.titleView = nil
    }
    required init(game: Game) {
        self.gameDescription = game
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDescription.gameDescriptionFields.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowInGameDescription(indexPath: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return gameDescription.gameDescriptionFields[indexPath.row](tableView, indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController, let cover = gameDescription.cover?.url else { return }
        gameDescription.didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController, url: cover)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveFavourite() {        
        saveFavouriteGame(
            game: gameDescription,
            platform: ( gameDescription.developers?.map(String.init).joined(separator: " - ")) ?? "",
            company: gameDescription.developers?.map(String.init).joined(separator: " - ") ?? "")
    }
    
    func removeFavourite() {
        deleteFavouriteGame(id: Int32(gameDescription.idGame))
    }
    
    
    
}
