import UIKit
import SafariServices

let offset_HeaderStop:CGFloat = 50.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 63.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 183.0 // The distance between the bottom of the Header and the top of the White Label

class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var headerImage: UIImageView?
    @IBOutlet weak var headerBlurImage: UIImageView?
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var footerView: UIView?
    @IBOutlet weak var homeButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?
    var blurredHeaderImageView: UIImageView?
    var referenceThumbnail: UIImageView?
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        _ = navigationController?.popViewController(animated: true)
    }
    var gameDescription: Game
    
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
        
        title = gameDescription.name
        tableView?.backgroundColor = UIColor.clear
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        navigationController?.isNavigationBarHidden = true
        
        
        backButton?.layer.shadowColor = UIColor.black.cgColor
        backButton?.layer.shadowOpacity = 3
        backButton?.layer.shadowOffset = CGSize.zero
        backButton?.layer.shadowRadius = 4
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel?.text = gameDescription.name
        guard let url = getHDImage(url: gameDescription.cover?.url) else { return }
        headerImage?.af_setImage(
            withURL: url,
            imageTransition: .crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                self.headerBlurImage?.image = self.headerImage?.image
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.init(rawValue: 10)!)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = (self.headerBlurImage?.bounds)!
                self.headerBlurImage?.addSubview(blurEffectView)
                
                
                //                self.headerImage = UIImageView(frame: headerView.bounds)
                //                self.headerImage?.contentMode = UIViewContentMode.scaleAspectFill
                //                guard let headerImage = self.headerImage, let titleLabel = self.titleLabel else { return }
                //                headerView.insertSubview(headerImage, aboveSubview: titleLabel)
                
                
                
                //                self.headerBlurImage?.image = headerImage.image?.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
                
        })
        headerBlurImage?.alpha = 0.0
        headerView?.clipsToBounds = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = tableView, let headerView = headerView, let referenceThumbnail = referenceThumbnail else { return }
        let offset = tableView.contentOffset.y
        var thumbnailTransform = CATransform3DIdentity
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
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / referenceThumbnail.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((referenceThumbnail.bounds.height * (1.0 + avatarScaleFactor)) - referenceThumbnail.bounds.height) / 2.0
            thumbnailTransform = CATransform3DTranslate(thumbnailTransform, 0, avatarSizeVariation, 0)
            thumbnailTransform = CATransform3DScale(thumbnailTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            //                        if offset <= offset_HeaderStop {
            //
            //                            if referenceThumbnail.layer.zPosition < headerView.layer.zPosition{
            //                                headerView.layer.zPosition = 0
            //                            }
            //
            //                        }else {
            //                            if referenceThumbnail.layer.zPosition >= headerView.layer.zPosition{
            //                                headerView.layer.zPosition = 1
            //                                backButton?.layer.zPosition = 2
            //                            }
            //                        }
        }
        
        
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDescription.gameDescriptionFields.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowInGameDescription(indexPath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverHDTableViewCell, for: indexPath) as! CoverHDTableViewCell
            //            cell.url = getHDImage(url: gameDescription.cover?.url)
            cell.backgroundColor = UIColor.clear
            cell.coverHQ?.image = #imageLiteral(resourceName: "emptyBackground")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
            if referenceThumbnail == nil {
                referenceThumbnail = cell.thumbnail
            }
            cell.url = getCoverMed(url: gameDescription.cover?.url)
            cell.name?.text = gameDescription.name
            cell.rating = Float(gameDescription.rating ?? 1)
            cell.layer.zPosition = 3
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.summaryTableViewCell, for: indexPath) as! SummaryTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.isSelected = false
            cell.textSummary = gameDescription.summary
            cell.summaryText?.textColor = ColorUI.text
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.company?.textColor = ColorUI.text
            if let developers = gameDescription.developers {
                nameCompanyDB(id: developers, callback: { nameCompany, new in
                    cell.company?.text = nameCompany
                    if new {
                        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
                            tableView.reloadData()
                        })
                    }
                })
            } else {
                cell.company?.text = "N.D."
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.publishedTableViewCell, for: indexPath) as! PublishedTableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.backgroundColor = ColorUI.background
            cell.firstReleaseDate?.textColor = ColorUI.text
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.genres?.textColor = ColorUI.text
            nameGenreDB(id: gameDescription.genres, callback: { nameGenre in
                cell.genres?.text = nameGenre
            })
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
            cell.backgroundColor = ColorUI.background
            cell.gameModes?.textColor = ColorUI.text
            nameGameModeDB(id: gameDescription.gameModes, callback: { nameGameModes in
                cell.gameModes?.text = nameGameModes
            })
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.screenshotsCollectionTableViewCell, for: indexPath) as! ScreenshotCollectionTableViewCell
            guard let screenshots = gameDescription.screenshots else { return cell }
            cell.screenshot = screenshots
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.relatedInDescriptionTableViewCell, for: indexPath) as! RelatedInDescriptionTableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.backgroundColor = ColorUI.background
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.videoCollectionTableViewCell, for: indexPath) as! VideoCollectionTableViewCell
            guard let videos = gameDescription.videos else { return cell }
            cell.video = videos
            return cell
        }
        //        let gameViewController = GameDescriptionTableViewController(game: gameDescription)
        //        return gameDescription.gameDescriptionFields[indexPath.row](tableView, indexPath, gameViewController)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        gameDescription.didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveFavourite(sender: UIButton) {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(GameDescriptionTableViewController.removeFavourite(sender:)))
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
    
    func removeFavourite(sender: UIButton) {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(GameDescriptionTableViewController.saveFavourite(sender:)))
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




