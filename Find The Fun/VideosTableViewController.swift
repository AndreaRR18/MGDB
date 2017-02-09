import UIKit
import SafariServices

class VideosTableViewController: UITableViewController {
    
    let videos: [Videos]
    
    init(videos: [Videos]) {
        self.videos = videos
        super.init(nibName: "VideosTableViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PlayTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayTableViewCell")
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
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayTableViewCell.cellPlayCellIdentifier, for: indexPath) as! PlayTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.url = getImagePreviewVideo(videoid: videos[indexPath.row].video_id)
        cell.titleVideo?.text = videos[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let idVideo = videos[indexPath.row].video_id else { return }
        let safariVC = SFSafariViewController(url: getVideo(videoid: idVideo)!)
        self.present(safariVC, animated: true, completion: nil)
    }
}
