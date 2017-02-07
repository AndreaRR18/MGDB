import UIKit
import CoreData

class FavouriteTableViewController: UITableViewController {
    
    var arrayFavouriteGames = [FavouriteGameData]()
    let logo = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCellTableViewCell")
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
        
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = "Favourite"
        getGame()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFavouriteGames.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCellTableViewCell.cellGameCellIdentifier, for: indexPath) as! GameCellTableViewCell
        let game = arrayFavouriteGames[indexPath.row]
        cell.cover?.image = #imageLiteral(resourceName: "img-not-found")
        cell.name?.text = game.name
        cell.years?.text = "\(game.firstReleaseDate)"
        return cell
    }
    
    
    func getGame() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            arrayFavouriteGames = try context.fetch(FavouriteGameData.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(FavouriteDescriptionTableViewController(favouriteGameDescription: arrayFavouriteGames[indexPath.row]), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        if editingStyle == .delete {
            let game = arrayFavouriteGames[indexPath.row]
            context.delete(game)
            appDelegate.saveContext()
            
            do {
                arrayFavouriteGames = try context.fetch(FavouriteGameData.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
}

