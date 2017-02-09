import UIKit
import CoreData

class FavouriteDescriptionTableViewController: UITableViewController {
    
    var favouriteGameDescription: FavouriteGameData
    let logo = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverTableViewCell")
        self.tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
        self.tableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableViewCell")
        self.tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
        
        title = favouriteGameDescription.name
        
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
        
        let removeFavourite = UIButton(type: .custom)
        removeFavourite.setTitle("Remove", for: .normal)
        removeFavourite.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        removeFavourite.addTarget(self, action: #selector(GameDescriptionTableViewController.removeFavourite), for: .touchUpInside)
        let removeGame = UIBarButtonItem(customView: removeFavourite)
        navigationItem.rightBarButtonItem = removeGame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = favouriteGameDescription.name
        tableView.reloadData()
    }
    
    required init(favouriteGameDescription: FavouriteGameData) {
        self.favouriteGameDescription = favouriteGameDescription
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowInGameDescription(indexPath: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.summaryTableViewCellIdentifier, for: indexPath) as! SummaryTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.isSelected = false
            cell.summaryText?.textColor = ColorUI.text
            cell.layer.cornerRadius = 20
            cell.summaryText?.text = favouriteGameDescription.summary
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.companyTableViewCellIdentifier, for: indexPath) as! CompanyTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.company?.textColor = ColorUI.text
            cell.layer.cornerRadius = 20
            cell.company?.text = "\(favouriteGameDescription.company)"
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.publishedTableViewCellIdentifier, for: indexPath) as! PublishedTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.firstReleaseDate?.textColor = ColorUI.text
            cell.layer.cornerRadius = 20
            cell.firstReleaseDate?.text = "\(favouriteGameDescription.firstReleaseDate)"
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.ratingTableViewCellIdentifier, for: indexPath) as! RatingTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.rate?.textColor = ColorUI.text
            cell.layer.cornerRadius = 20
            cell.rate?.text = "\(favouriteGameDescription.rating)"
            return cell
        }
    }
    
    func removeFavourite(sender: UIButton) {
        deleteFavouriteGame(id: Int32(favouriteGameDescription.id))
    }
    
    
}


