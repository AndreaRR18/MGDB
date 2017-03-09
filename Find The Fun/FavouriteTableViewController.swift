//import UIKit
//import CoreData
//import Foundation
//
//class FavouriteTableViewController: UITableViewController {
//    
//    var arrayFavouriteGames = [FavouriteGameData]()
//    let logo = UIImageView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        self.tableView.register(UINib(nibName: NibName.gameCellTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameCellTableViewCell)
//        let viewFooter = UIView()
//        viewFooter.backgroundColor = ColorUI.backgoundTableView
//        self.tableView.tableFooterView = viewFooter
//        self.view.backgroundColor = ColorUI.backgoundTableView
//        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
//        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
//        tabBarController?.tabBar.tintColor = UIColor.white
//        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
//        tabBarController?.tabBar.isTranslucent = false
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if navigationController?.isNavigationBarHidden == true {
//            navigationController?.setNavigationBarHidden(false, animated: animated)
//        }
//
//        navigationItem.title = "Favourite"
//        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
//        navigationController?.navigationBar.barTintColor = ColorUI.navBar
//        getGame()
//        tableView.reloadData()
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayFavouriteGames.count
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//    
//    
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let game = GameCell(game: arrayFavouriteGames[indexPath.row])
////        return game.getCell(tableView: tableView, indexPath: indexPath)
////        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameCellTableViewCell, for: indexPath) as! GameCellTableViewCell
////        let game = arrayFavouriteGames[indexPath.row]
////        cell.cover?.image = UIImage(data: game.image as! Data)
////        cell.name?.text = game.name
////        cell.years?.text = ""
////        return cell
////    }
//    
//    
//    func getGame() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
//        do {
//            arrayFavouriteGames = try context.fetch(FavouriteGameData.fetchRequest())
//        } catch {
//            print("Fetching Failed")
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        navigationController?.pushViewController(FavouriteDescriptionTableViewController(favouriteGameDescription: arrayFavouriteGames[indexPath.row]), animated: true)
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
//        if editingStyle == .delete {
//            let game = arrayFavouriteGames[indexPath.row]
//            context.delete(game)
//            appDelegate.saveContext()
//            do {
//                arrayFavouriteGames = try context.fetch(FavouriteGameData.fetchRequest())
//            } catch {
//                print("Fetching Failed")
//            }
//        }
//        tableView.reloadData()
//    }
//}
//
//
