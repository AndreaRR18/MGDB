import UIKit
import SafariServices

let offset_HeaderStop:CGFloat = 50.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 61.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 173.0 // The distance between the bottom of the Header and the top of the White Label

class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var headerImage: UIImageView?
    @IBOutlet weak var headerBlurImage: UIImageView?
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?
    var blurredHeaderImageView: UIImageView?
    var referenceThumbnail: UIImageView?
    var gameDescription: Game
    
    @IBAction func backButtonAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonAction(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        saveFavourite()
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let firstActivityItem = "Look this game:"
        let secondActivityItem : NSURL = NSURL(string: gameDescription.internetPage!)!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        activityViewController.popoverPresentationController?.permittedArrowDirections = .unknown
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        activityViewController.excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    required init(game: Game) {
        self.gameDescription = game
        super.init(nibName: "DescriptionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: NibName.coverHDTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.coverHDTableViewCell)
        tableView?.register(UINib(nibName: NibName.coverTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.coverTableViewCell)
        tableView?.register(UINib(nibName: NibName.summaryTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.summaryTableViewCell)
        tableView?.register(UINib(nibName: NibName.companyTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.companyTableViewCell)
        tableView?.register(UINib(nibName: NibName.publishedTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.publishedTableViewCell)
        tableView?.register(UINib(nibName: NibName.platformTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.platformTableViewCell)
        tableView?.register(UINib(nibName: NibName.ratingTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.ratingTableViewCell)
        tableView?.register(UINib(nibName: NibName.screenshotsCollectionTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.screenshotsCollectionTableViewCell)
        tableView?.register(UINib(nibName: NibName.genreTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.genreTableViewCell)
        tableView?.register(UINib(nibName: NibName.gameModesTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameModesTableViewCell)
        tableView?.register(UINib(nibName: NibName.relatedInDescriptionTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.relatedInDescriptionTableViewCell)
        tableView?.register(UINib(nibName: NibName.videoCollectionTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.videoCollectionTableViewCell)
        tableView?.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel?.text = gameDescription.name
        
        guard let url = getHDImage(url: gameDescription.cover?.url) else { return }
        headerImage?.af_setImage(
            withURL: url,
            imageTransition: .crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                self.headerBlurImage?.image = self.headerImage?.image
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = (self.headerBlurImage?.bounds)!
                self.headerBlurImage?.addSubview(blurEffectView)
        })
        
        if navigationController?.isNavigationBarHidden == false {
            navigationController?.setNavigationBarHidden(true, animated: animated)
            
        }
        
        tabBarController?.tabBar.isTranslucent = false
        headerBlurImage?.alpha = 0.0
        headerView?.clipsToBounds = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = tableView, let headerView = headerView else { return }
        let offset = tableView.contentOffset.y
        var headerTrasform = CATransform3DIdentity
        if offset < CGFloat(0) {
            let headerScaleFactor: CGFloat = -(offset) / headerView.bounds.height
            let headerSizeVariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2.0
            headerTrasform = CATransform3DTranslate(headerTrasform, 0, headerSizeVariation, 0)
            headerTrasform = CATransform3DScale(headerTrasform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            headerView.layer.transform = headerTrasform
        } else {
            headerTrasform = CATransform3DTranslate(headerTrasform, 0, max(-offset_HeaderStop, -offset), 0)
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset - 90), 0)
            titleLabel?.layer.transform = labelTransform
            
            headerBlurImage?.alpha = min(1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
        }
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDescriptionFields.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 90
        case 1:
            return 90
        case 2:
            return 250
        case 3:
            return 60
        case 4:
            return 60
        case 5:
            return 60
        case 6:
            return 60
        case 7:
            guard gameDescription.screenshots != nil else { return 0 }
            return 150
        case 8:
            return 60
        case 9:
            guard gameDescription.videos != nil else { return 0 }
            return 160
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return gameDescriptionFields[indexPath.row](tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        gameDescription.didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveFavourite() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeFavourite))
        navigationItem.rightBarButtonItem = trashButton
        let cover = UIImageView()
        cover.af_setImage(
            withURL: getCover(url: gameDescription.cover?.url)!,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                saveFavouriteGame(
                    game: self.gameDescription,
                    image: cover.image!)
        })
    }
    
    func removeFavourite() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveFavourite))
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete \(gameDescription.name)", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            deleteFavouriteGame(id: Int32(self.gameDescription.idGame))
            self.navigationItem.rightBarButtonItem = saveButton
        }
        alertController.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
}

extension DescriptionViewController: VideoDelegate, ScreenshotDelegate {
    func openSafariView(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func openImage(url: String) {
        navigationController?.present(CoverViewController(coverURL: url), animated: true, completion: nil)
    }
    
    
}


extension DescriptionViewController {
    
    var gameDescriptionFields: [(UITableView,IndexPath) -> UITableViewCell] {
        return [
            { (tableView, indexPath) -> UITableViewCell in
                self.getCellCoverHD(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellCover(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellSummary(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellCompany(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellPublished(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellGenres(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellGameModes(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellScreenshots(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellRelatedInDescription(tableView: tableView, indexPath: indexPath)
            },
            { (tableView, indexPath) -> UITableViewCell in
                self.getCellVideos(tableView: tableView, indexPath: indexPath)
            }
        ]
    }
    
    
    func getCellCoverHD(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverHDTableViewCell, for: indexPath) as! CoverHDTableViewCell
        cell.configureCoverHDTableViewCell()
        return cell
    }
    
    func getCellCover(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
        cell.configureCoverTableViewCell(gameDescription.cover, gameDescription.name, gameDescription.rating)
        return cell
    }
    
    func getCellSummary(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.summaryTableViewCell, for: indexPath) as! SummaryTableViewCell
        cell.configureSummaryTableViewCell(gameDescription.summary)
        return cell
    }
    
    func getCellCompany(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
        if let developers = gameDescription.developers {
            nameCompanyDB(id: developers, callback: { nameCompany, new in
                cell.configureCompanyTableViewCell(nameCompany)
                if new {
                    _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
                        tableView.reloadData()
                    })
                }
            })
        }
        return cell
    }
    
    func getCellPublished(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.publishedTableViewCell, for: indexPath) as! PublishedTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.backgroundColor = ColorUI.background
        return cell
    }
    
    func getCellGenres(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
        nameGenreDB(id: gameDescription.genres, callback: { nameGenre in
            cell.configureGenreTableViewCell(nameGenre)
        })
        return cell
    }
    
    func getCellGameModes(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
        nameGameModeDB(id: gameDescription.gameModes, callback: { nameGameModes in
            cell.configureGameModesTableViewCell(nameGameModes)
        })
        return cell
    }
    
    func getCellScreenshots(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.screenshotsCollectionTableViewCell, for: indexPath) as! ScreenshotCollectionTableViewCell
        if gameDescription.screenshots == nil || gameDescription.screenshots?.count == 0 { cell.screenshotLabel?.text = "" }
        guard let screenshots = gameDescription.screenshots else { return cell }
        if screenshots.count == 0 { cell.screenshotLabel?.text = "" }
        cell.configureScreenshotCollectionTableViewCell(screenshots)
        cell.delegate = self
        return cell
    }
    
    func getCellRelatedInDescription(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.relatedInDescriptionTableViewCell, for: indexPath) as! RelatedInDescriptionTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func getCellVideos(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.videoCollectionTableViewCell, for: indexPath) as! VideoCollectionTableViewCell
        if gameDescription.videos == nil || gameDescription.videos?.count == 0 { cell.videoLabel?.text = "" }
        guard let videos = gameDescription.videos else { return cell }
        cell.configureVideoCollectionTableViewCell(videos)
        cell.delegate = self
        return cell
    }
    
    
}




