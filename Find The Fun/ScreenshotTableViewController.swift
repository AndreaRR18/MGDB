//import UIKit
//
//class ScreenshotTableViewController: UITableViewController {
//
//    var arrayScreenshots: [Screenshots]
//    
//    init(arrayScreenshots: [Screenshots]) {
//        self.arrayScreenshots = arrayScreenshots
//        super.init(nibName: "ScreenshotTableViewController", bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Screenshots"
//        self.tableView.register(UINib(nibName: "PreviewScreenshotTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviewScreenshotTableViewCell")
//        let viewFooter = UIView()
//        viewFooter.backgroundColor = ColorUI.backgoundTableView
//        self.tableView.tableFooterView = viewFooter
//        self.view.backgroundColor = ColorUI.backgoundTableView
//        let activityIndicator = ActivityIndicator(view: view)
//        activityIndicator.startAnimating()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
//            activityIndicator.stopAnimating()
//        })
//
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayScreenshots.count
//    }
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PreviewScreenshotTableViewCell.cellReleaseDateCellIdentifier, for: indexPath) as! PreviewScreenshotTableViewCell
//        cell.url = getHDImage(url: arrayScreenshots[indexPath.row].url)
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        navigationController?.pushViewController(CoverViewController(coverURL: arrayScreenshots[indexPath.row].url), animated: true)
//    }
//}
