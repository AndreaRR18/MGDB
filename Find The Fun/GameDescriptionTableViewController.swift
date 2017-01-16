import UIKit

class GameDescriptionTableViewController: UITableViewController {
    
    let arrayGamesDescription : [CellFactory] = [darkSoulsName, darkSoulsSummary, darkSoulsCompany, darkSoulsPublished, darkSoulsPlatform, darkSoulsGnres, darkSoulsRating]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "NamePhotoTableviewCell", bundle: nil), forCellReuseIdentifier: "NamePhotoTableviewCell")
        self.tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
        self.tableView.register(UINib(nibName: "CompanyTableviewCell", bundle: nil), forCellReuseIdentifier: "CompanyTableviewCell")
        self.tableView.register(UINib(nibName: "PublishedTableviewCell", bundle: nil), forCellReuseIdentifier: "PublishedTableviewCell")
        self.tableView.register(UINib(nibName: "PlatformTableviewCell", bundle: nil), forCellReuseIdentifier: "PlatformTableviewCell")
        self.tableView.register(UINib(nibName: "GnresTableviewCell", bundle: nil), forCellReuseIdentifier: "GnresTableviewCell")
        self.tableView.register(UINib(nibName: "RatingTableviewCell", bundle: nil), forCellReuseIdentifier: "RatingTableviewCell")
        self.tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGamesDescription.count
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return arrayGamesDescription[indexPath.row].getCell(tableView: tableView, indexPath: indexPath)
    }
}
