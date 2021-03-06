import UIKit
import SafariServices

let offset_HeaderStop:CGFloat = 50.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 90.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 173.0 // The distance between the bottom of the Header and the top of the White Label

final class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak private var tableView: UITableView?
    @IBOutlet weak private var headerImage: UIImageView?
    @IBOutlet weak private var headerBlurImage: UIImageView?
    @IBOutlet weak private var headerView: UIView?
    @IBOutlet weak private var backButton: UIButton?
    @IBOutlet weak private var titleLabel: UILabel?
    
    private var blurredHeaderImageView: UIImageView?
    private var referenceThumbnail: UIImageView?
    private var gameDescription: Game
    private var arrayDevelopers: [DeveloperCell] = []
    private var arrayPublishers: [PublisherCell] = []
    private var arrayReleaseDate: [ReleaseDateCell] = []
    private var cellFactories: [[CellFactory]] = []
    private let titleSection = ["", "Summary", "Developers", "Publishers", "Release Date", "Genres", "Games Mode", "Screenshots", "Video", ""]
    
    required init(game: Game) {
        self.gameDescription = game
        super.init(nibName: "DescriptionViewController", bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel?.text = gameDescription.name
        
        guard let url = GetUrl.getHDImage(url: gameDescription.cover?.url), let boundHeader = self.headerBlurImage?.bounds else { return }
        
        headerImage?.af_setImage(
            withURL: url,
            imageTransition: .crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                self.headerBlurImage?.image = self.headerImage?.image
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = boundHeader
                self.headerBlurImage?.addSubview(blurEffectView)
        })
        
        if navigationController?.isNavigationBarHidden == false {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
        tabBarController?.tabBar.isTranslucent = false
        
        headerBlurImage?.alpha = 0.0
        
        headerView?.clipsToBounds = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(
            UINib(nibName: NibName.coverHDTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.coverHDTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.coverTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.coverTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.summaryTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.summaryTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.companyTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.companyTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.releaseDatePlatformTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.releaseDatePlatformTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.platformTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.platformTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.ratingTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.ratingTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.screenshotsCollectionTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.screenshotsCollectionTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.genreTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.genreTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.gameModesTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.gameModesTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.videoCollectionTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.videoCollectionTableViewCell)
        tableView?.register(
            UINib(nibName: NibName.relatedInDescriptionTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.relatedInDescriptionTableViewCell)
        
        buildTableDescription()
        
        tableView?.backgroundColor = UIColor.clear
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
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
            
            headerTrasform = CATransform3DTranslate(
                headerTrasform,
                0,
                headerSizeVariation,
                0)
            
            headerTrasform = CATransform3DScale(
                headerTrasform,
                1.0 + headerScaleFactor,
                1.0 + headerScaleFactor,
                0)
            
            headerView.layer.transform = headerTrasform
        } else {
            
            headerTrasform = CATransform3DTranslate(
                headerTrasform,
                0,
                max(-offset_HeaderStop, -offset),
                0)
            
            let labelTransform = CATransform3DMakeTranslation(
                0,
                max(-distance_W_LabelHeader, offset_B_LabelHeader - offset - 90),
                0)
            
            titleLabel?.layer.transform = labelTransform
            
            headerBlurImage?.alpha = min(1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
        }
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellFactories[section].count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellFactories.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleSectionCustom = UILabel()
        
        headerView.backgroundColor = ColorUI.headerInSection
        headerView.addSubview(titleSectionCustom)
        
        titleSectionCustom.text = titleSection[section]
        titleSectionCustom.translatesAutoresizingMaskIntoConstraints = false
        titleSectionCustom.sizeToFit()
        titleSectionCustom.textColor = UIColor.black
        titleSectionCustom.font = UIFont.boldSystemFont(ofSize: 15)
        
        let leadingConstranint = titleSectionCustom
            .leadingAnchor
            .constraint(
                equalTo: headerView.leadingAnchor,
                constant: 10)
        
        let bottomConstraint = titleSectionCustom
            .bottomAnchor
            .constraint(
                equalTo: headerView.bottomAnchor,
                constant: -10)
        
        let widthConstraint = titleSectionCustom
            .widthAnchor
            .constraint(
                equalTo: headerView.widthAnchor,
                constant: 300)
        
        let constraint = [leadingConstranint, bottomConstraint, widthConstraint]
        
        NSLayoutConstraint.activate(constraint)
        
        headerView.addConstraints(constraint)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightSectionDescription(section, gameDescription)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowInGameDescription(indexPath: indexPath, gameDescription: gameDescription)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactories[indexPath.section][indexPath.row]
            .getCell(
                tableView: tableView,
                indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        cellFactories[indexPath.section][indexPath.row]
            .didSelectCell(
                tableView: tableView,
                indexPath: indexPath,
                navigationController: navController)
    }
    
    
    func buildTableDescription() {
        let header = HeaderCell()
        let cover = CoverCell(gameDescription, navigationController, tableView)
        let summary = SummaryCell(gameDescription.summary)
        
        gameDescription.developers?.forEach { idDeveloper in
            arrayDevelopers.append(DeveloperCell(idDeveloper))
        }
        
        gameDescription.publishers?.forEach { idPublishers in
            arrayPublishers.append(PublisherCell(idPublishers))
        }
        
        gameDescription.releaseDate?.forEach { releaseDate in
            arrayReleaseDate.append(ReleaseDateCell(releaseDate))
        }
        
        let genres = GenreCell(gameDescription.genres ?? [])
        let gamesMode = GameModeCell(gameDescription.gameModes ?? [])
        let screenshots = ScreenshotCell(screenshots: gameDescription.screenshots, navigationController: navigationController)
        let related = RelatedCell(gameDescription.genres ?? [])
        let video = VideoCell(video: gameDescription.videos, navigationController: navigationController)
        
        cellFactories = [[header, cover], [summary], arrayDevelopers, arrayPublishers, arrayReleaseDate, [genres], [gamesMode], [screenshots], [video], [related] ]
    }
}
