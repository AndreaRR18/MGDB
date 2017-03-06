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


class CoverCell: CellFactory {
    private let cover: Cover?
    private let name: String
    private let rating: Int?
    
    init( _ cover: Cover?, _ name: String, _ rating: Int?) {
        self.cover = cover
        self.name = name
        self.rating = rating
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        guard let url = cover?.url else { return }
        navigationController.present(CoverViewController(coverURL: url), animated: true, completion: nil)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
        cell.configureCoverTableViewCell(cover, name, rating)
        return cell
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
    private let releaseDate: [ReleaseDate]
    
    init(_ releaseDate: [ReleaseDate]) {
        self.releaseDate = releaseDate
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        navigationController.navigationBar.isTranslucent = false
        navigationController.pushViewController(ReleaseDateTableViewController(arrayReleaseDate: releaseDate), animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.publishedTableViewCell, for: indexPath) as! PublishedTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.backgroundColor = ColorUI.background
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
        guard let navigationController = navigationController else { return }
        navigationController.present(CoverViewController(coverURL: url), animated: true, completion: nil)
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
