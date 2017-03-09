import Foundation
import UIKit
import SafariServices

protocol CellFactory {
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController)
}

class GameCell: CellFactory {
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        navigationController.pushViewController(DescriptionViewController(game: game), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameCellTableViewCell, for: indexPath) as! GameCellTableViewCell
        cell.configureGameCell(game)
        return cell
    }
}

class HeaderCell: CellFactory {
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverHDTableViewCell, for: indexPath) as! CoverHDTableViewCell
        cell.configureCoverHDTableViewCell()
        return cell
    }
}


class CoverCell: CellFactory, ShareDelegate, FavouriteDelegate, ShowCoverDelegate {
    private let game: Game?
    private let navController: UINavigationController?
    private let tableView: UITableView?
    
    init(_ game: Game?, _ navController: UINavigationController?, _ tableView: UITableView?) {
        self.game = game
        self.navController = navController
        self.tableView = tableView
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
        cell.configureCoverTableViewCell(game)
        cell.favouriteDelegate = self
        cell.shareDelegate = self
        cell.showCoverDelegate = self
        return cell
    }
    
    func saveGame(game: Game?) {
        guard let game = game else { return }
        let cover = UIImageView()
        let activityIndicator = ActivityIndicator(view: self.tableView!, background: .clear, activityIndicatorColor: .darkGray)
        activityIndicator.startAnimating()
        cover.af_setImage(
            withURL: getCover(url: game.cover?.url)!,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                guard let cover = cover.image else { return }
                                saveFavouriteGame(
                    game: game,
                    image: cover)
                activityIndicator.stopAnimating()
                self.tableView?.reloadData()
                NotificationCenter.default.post(name: NSNotification.Name("ChangeFavouriteGame"), object: nil)
        })
    }
    
    func removeGame(game: Game?) {
        guard let game = game else { return }
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete \(game.name)", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            deleteFavouriteGame(id: Int32(game.idGame))
            self.tableView?.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name("ChangeFavouriteGame"), object: nil)
        }
        alertController.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        navController?.present(alertController, animated: true, completion: nil)
    }
    
    func shareGame() {
            guard let page = self.game?.internetPage else { return }
            let defaultText: Any = "Just checking in at " + "m."+page.replacingOccurrences(of: "https://www.", with: "")
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.navController?.present(activityController, animated: true, completion: nil)
    }
    
    func showCover() {
        guard let url = game?.cover?.url else { return }
        navController?.present(CoverViewController(coverURL: url), animated: true, completion: nil)
    }

    
}


class SummaryCell: CellFactory {
    private let summary: String?
    
    init(_ summary: String?) {
        self.summary = summary
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.summaryTableViewCell, for: indexPath) as! SummaryTableViewCell
        cell.configureSummaryTableViewCell(summary)
        return cell
    }
}


class CompanyCell: CellFactory {
    
    private let company: Int
    
    init(_ company: Int) {
        self.company = company
    }
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
        companyDB(id: company, callback: { nameCompany, new in
            cell.configureCompanyTableViewCell(nameCompany)
            if new {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    tableView.reloadData()
                })
            }
        })
        return cell
    }
}

class PublisherCell: CellFactory {
    
    private let company: Int
    
    init(_ company: Int) {
        self.company = company
    }
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
        companyDB(id: company, callback: { nameCompany, new in
            print(nameCompany)
            cell.configureCompanyTableViewCell(nameCompany)
            if new {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    tableView.reloadData()
                })
            }
        })
        return cell
    }
}
class DeveloperCell: CellFactory {
    
    private let company: Int
    
    init(_ company: Int) {
        self.company = company
    }
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
        companyDB(id: company, callback: { nameCompany, new in
            cell.configureCompanyTableViewCell(nameCompany)
            if new {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    tableView.reloadData()
                })
            }
        })
        return cell
    }
}

class ReleaseDateCell: CellFactory {
    private let releaseDate: ReleaseDate
    
    init(_ releaseDate: ReleaseDate) {
        self.releaseDate = releaseDate
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.releaseDatePlatformTableViewCell, for: indexPath) as! ReleaseDatePlatformTableViewCell
        cell.backgroundColor = ColorUI.background
        namePlatformDB(id: releaseDate.platform, callback: { namePlatform, new in
            cell.configureReleaseDateTableViewCell(namePlatform, self.releaseDate.human)
            if new {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    tableView.reloadData()
                })
            }

        })
        return cell
    }
}

class GenreCell: CellFactory {
    private let genre: [Int]
    
    init(_ genre: [Int]) {
        self.genre = genre
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
        nameGenreDB(id: genre, callback: { nameGenre in
            cell.configureGenreTableViewCell(nameGenre)
        })
        return cell
    }
}

class GameModeCell: CellFactory {
    private let gameMode: [Int]
    
    init(_ gameMode: [Int]) {
        self.gameMode = gameMode
    }
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
        nameGameModeDB(id: gameMode, callback: { nameGameModes in
            cell.configureGameModesTableViewCell(nameGameModes)
        })
        return cell
    }
}

class RelatedCell: CellFactory {
    
    private let genre: [Int]
    
    init(_ genre: [Int]) {
        self.genre = genre
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        navigationController.navigationBar.isTranslucent = false
        navigationController.pushViewController(RelatedTableViewController(idGenres: genre), animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.relatedInDescriptionTableViewCell, for: indexPath) as! RelatedInDescriptionTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
}

class ScreenshotCell: CellFactory, ScreenshotDelegate {
    
    private let screenshots: [Screenshot]?
    private let navigationController: UINavigationController?
    
    init(screenshots: [Screenshot]?, navigationController: UINavigationController?) {
        self.screenshots = screenshots
        self.navigationController = navigationController
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.screenshotsCollectionTableViewCell, for: indexPath) as! ScreenshotCollectionTableViewCell
        if screenshots == nil || screenshots?.count == 0 { cell.screenshotLabel?.text = "" }
        guard let screenshots = screenshots else { return cell }
        if screenshots.count == 0 { cell.screenshotLabel?.text = "" }
        cell.configureScreenshotCollectionTableViewCell(screenshots)
        cell.delegate = self
        return cell
    }
    
    func openImage(url: String) {
        guard let navController = navigationController else { return }
        navController.present(CoverViewController(coverURL: url), animated: true, completion: nil)
    }
    
}


class VideoCell: CellFactory, VideoDelegate {
    
    private let video: [Video]?
    private let navigationController: UINavigationController?
    
    init(video: [Video]?, navigationController: UINavigationController?) {
        self.video = video
        self.navigationController = navigationController
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.videoCollectionTableViewCell, for: indexPath) as! VideoCollectionTableViewCell
        if video == nil || video?.count == 0 { cell.videoLabel?.text = "" }
        guard let video = video else { return cell }
        cell.configureVideoCollectionTableViewCell(video)
        cell.delegate = self
        return cell
    }
    
    func openSafariView(_ url: URL) {
        guard let navigationController = navigationController else { return }
    let safariVC = SFSafariViewController(url: url)
    navigationController.present(safariVC, animated: true, completion: nil)
    }
}
