import UIKit

class ReleaseDateTableViewController: UITableViewController {
    
    var arrayReleaseDate: [ReleaseDate]?
    
    required init(arrayReleaseDate: [ReleaseDate]?) {
        self.arrayReleaseDate = arrayReleaseDate
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = "Release Date"
        let activityIndicator = ActivityIndicator(view: view)
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            activityIndicator.stopAnimating()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ReleaseDateTableViewCell", bundle: nil), forCellReuseIdentifier: "ReleaseDateTableViewCell")
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let arrayReleaseDate = arrayReleaseDate else { return 0 }
        return arrayReleaseDate.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReleaseDateTableViewCell.cellReleaseDateCellIdentifier, for: indexPath) as! ReleaseDateTableViewCell
        if let arrayReleaseDate = arrayReleaseDate {
            cell.date?.text = arrayReleaseDate[indexPath.row].human
            cell.backgroundColor = ColorUI.background
            cell.platform?.textColor = ColorUI.text
            let decodedJSON = DecodeJSON(url: getUrlIDPlatform(idPlatform: arrayReleaseDate[indexPath.row].platform!))
            decodedJSON.getPlatform(callback: { platforms in
                if let url = getLogoThumbnail(cloudinaryid: platforms.first!.logoPlatform?.cloudinary_id) {
                    cell.url = url
                }
            })
            namePlatformDB(id: arrayReleaseDate[indexPath.row].platform, callback: { namePlatform in
                cell.platform?.text = namePlatform
            })
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
