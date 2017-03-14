import UIKit
import SafariServices


class FavouriteDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet weak var headerImage: UIImageView?
    
    @IBOutlet weak var headerBlurImage: UIImageView?
    
    @IBOutlet weak var headerView: UIView?
    
    @IBOutlet weak var backButton: UIButton?
    
    @IBOutlet weak var titleLabel: UILabel?
    
    private var blurredHeaderImageView: UIImageView?
    
    private var referenceThumbnail: UIImageView?
    
    private var gameDescription: FavouriteGameData
    
    private var arrayDevelopers: [DeveloperCell] = []
    
    private var arrayPublishers: [PublisherCell] = []
    
    private var arrayReleaseDate: [ReleaseDateCell] = []
    
    private var cellFactories: [[CellFactory]] = []
    
    private let titleSection = ["", "Summary", "Developers", "Publishers", "Release Date", "Genres", "Games Mode", "Screenshots", "Video", ""]
    
    
    required init(game: FavouriteGameData) {
        
        self.gameDescription = game
        
        super.init(nibName: "DescriptionViewController", bundle: nil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        headerImage?.image = UIImage(data: gameDescription.image as! Data)
        
        if navigationController?.isNavigationBarHidden == false {
            
            navigationController?.setNavigationBarHidden(true, animated: animated)
            
        }
        
        titleLabel?.text = gameDescription.name
        
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
            UINib(nibName: NibName.relatedInDescriptionTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.relatedInDescriptionTableViewCell)
        
        tableView?.register(
            UINib(nibName: NibName.videoCollectionTableViewCell, bundle: nil),
            forCellReuseIdentifier: Identifier.videoCollectionTableViewCell)
        
        buildTableDescription()
        
        tableView?.backgroundColor = UIColor.clear
        
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
                max(-distance_W_LabelHeader,
                    offset_B_LabelHeader - offset - 90),
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
        
        return heightFavouriteSectionDescription(
            section,
            gameDescription)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 105
        case 1:
            guard let summary = gameDescription.summary, summary.characters.count > 0 else { return 0 }
            return 250
        case 2:
            return 50
        case 3:
            guard gameDescription.developers != nil else { return 0 }
            return 50
        case 4:
            guard gameDescription.publishers != nil else { return 0 }
            return 50
        case 5:
            return 50
        case 6:
            return 50
        case 7:
            return 50
        case 8:
            return 160
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cellFactories[indexPath.section][indexPath.row]
            .getCell(
                tableView: tableView,
                indexPath: indexPath)
        
    }
    
    
    func buildTableDescription() {
        
        let game = Game(
            idGame: Int(gameDescription.id),
            name: gameDescription.name ?? "",
            summary: gameDescription.summary,
            rating: Int(gameDescription.rating),
            developers: gameDescription.developers?.trimmingCharacters(in: CharacterSet(charactersIn: "[]")).components(separatedBy: ", ").flatMap{ Int($0) },
            publishers: gameDescription.developers?.trimmingCharacters(in: CharacterSet(charactersIn: "[]")).components(separatedBy: ", ").flatMap{ Int($0) },
            updatedAt: nil,
            releaseDate: nil,
            cover: nil,
            genres: gameDescription.genre?.trimmingCharacters(in: CharacterSet(charactersIn: "[]")).components(separatedBy: ", ").flatMap{ Int($0) },
            gameModes: gameDescription.gamemode?.trimmingCharacters(in: CharacterSet(charactersIn: "[]")).components(separatedBy: ", ").flatMap{ Int($0) },
            screenshots: nil,
            internetPage: gameDescription.internetPage,
            videos: nil)
        
        
        let header = HeaderCell()
        
        let cover = FavouriteCoverCell(
            name: game.name,
            cover: UIImage(data: gameDescription.image as! Data),
            rating: game.rating,
            internetPage: game.internetPage,
            navController: navigationController,
            tableView: tableView)
        
        let summary = SummaryCell(gameDescription.summary)
        
        
        //        let developers = DeveloperCell()
        
        //        let publishers = PublisherCell()
        
        let genres = GenreCell(game.genres ?? [])
        
        let gamesMode = GameModeCell(game.gameModes ?? [])
        
        cellFactories = [[header, cover], [summary], [genres], [gamesMode] ]
    }
    
}
