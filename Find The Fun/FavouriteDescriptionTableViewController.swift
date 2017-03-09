//import UIKit
//import CoreData
//
//class FavouriteDescriptionTableViewController: UITableViewController {
//    
//    var favouriteGameDescription: FavouriteGameData
//    let logo = UIImageView()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        self.tableView.register(UINib(nibName: NibName.coverHDTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.coverHDTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.coverTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.coverTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.summaryTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.summaryTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.companyTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.companyTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.publishedTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.publishedTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.platformTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.platformTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.ratingTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.ratingTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.genreTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.genreTableViewCell)
//        self.tableView.register(UINib(nibName: NibName.gameModesTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameModesTableViewCell)
//        
//        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
//        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
//        tabBarController?.tabBar.tintColor = UIColor.white
//        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
//        
//        
//        navigationItem.title = favouriteGameDescription.name
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
//        
//        let backItem = UIBarButtonItem()
//        backItem.title = nil
//        tabBarController?.navigationItem.backBarButtonItem = backItem
//        
//        view.backgroundColor = ColorUI.backgoundTableView
//        
//        let viewFooter = UIView()
//        viewFooter.backgroundColor = ColorUI.backgoundTableView
//        tableView.tableFooterView = viewFooter
//        view.backgroundColor = ColorUI.backgoundTableView
//        navigationController?.navigationBar.barTintColor = ColorUI.navBar
//        
//        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeFavourite(sender:)))
//        navigationItem.rightBarButtonItem = trashButton
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if navigationController?.isNavigationBarHidden == true {
//            navigationController?.setNavigationBarHidden(false, animated: animated)
//        }
//
//        tabBarController?.navigationItem.titleView = nil
//        tabBarController?.navigationItem.title = favouriteGameDescription.name
//        tableView.reloadData()
//    }
//    
//    required init(favouriteGameDescription: FavouriteGameData) {
//        self.favouriteGameDescription = favouriteGameDescription
//        super.init(style: .plain)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 7
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return heightRowInGameDescription(indexPath: indexPath.row)
//    }
//    
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        switch indexPath.row {
////        case 0:
////            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverHDTableViewCell, for: indexPath) as! CoverHDTableViewCell
////            cell.coverHQ?.image = UIImage(data: favouriteGameDescription.image as! Data)
////            return cell
////        case 1:
////            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
////            cell.thumbnail?.image = UIImage(data: favouriteGameDescription.image as! Data)
////            cell.name?.text = favouriteGameDescription.name
////            cell.layer.zPosition = 2
////            return cell
////        case 2:
////            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.summaryTableViewCell, for: indexPath) as! SummaryTableViewCell
////            cell.summary?.text = favouriteGameDescription.summary
////            return cell
////        case 3:
////            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
////            cell.company?.text = favouriteGameDescription.company
////            return cell
////        case 4:
////            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.ratingTableViewCell, for: indexPath) as! RatingTableViewCell
////            cell.rate?.text = "\(favouriteGameDescription.rating)"
////            return cell
////        case 5:
////            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
////            cell.genres?.text = favouriteGameDescription.genre
////            return cell
////        default:
////            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
////            cell.gameModes?.text = favouriteGameDescription.gamemode
////            return cell
////        }
////    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    func removeFavourite(sender: UIButton) {
//        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete \(favouriteGameDescription.name ?? "")", preferredStyle: .actionSheet)
//        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
//            deleteFavouriteGame(id: Int32(self.favouriteGameDescription.id))
//            _ = self.navigationController?.popViewController(animated: true)
//        }
//        alertController.addAction(deleteAction)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alertController.addAction(cancelAction)
//        navigationController?.present(alertController, animated: true, completion: nil)
//    }
//}
//
//
