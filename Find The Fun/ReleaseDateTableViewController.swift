import UIKit

class ReleaseDateTableViewController: UITableViewController {
    
    var arrayReleaseDate: [ReleaseDate]?
    
    var activityIndicatorAppeared = true
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var activityIndicatorFooter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var viewActivityIndicatorFooter = UIView()
    
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
        
        if activityIndicatorAppeared {
            activityIndicatorAppeared = false
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
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
                    cell.logo?.af_setImage(
                        withURL: url,
                        placeholderImage: #imageLiteral(resourceName: "img-not-found"),
                        runImageTransitionIfCached: true)
                } else {
                    cell.logo?.image = #imageLiteral(resourceName: "img-not-found")
                }
            })

           
            
            namePlatformDB(id: arrayReleaseDate[indexPath.row].platform, callback: { namePlatform in
                cell.platform?.text = namePlatform
                self.activityIndicator.stopAnimating()
            })
        }
        return cell
    }
}
