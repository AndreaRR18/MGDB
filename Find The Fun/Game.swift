import Foundation
import UIKit

struct Game {
    let idGame: Int
    let name: String?
    let firstReleaseDate: String?
    let company: String?
    
    //cover will became string
    let cover: UIImage
    let summary: String?
    let platform: String?
    let rate: String?
    let identifier = GameCellTableViewCell.cellGameCellIdentifier
    
    init(idGame: Int, name: String, firstReleaseDate: String, company: String, cover: UIImage, summary: String, platform: String, rate: String) {
        self.idGame = idGame
        self.name = name
        self.firstReleaseDate = firstReleaseDate
        self.company = company
        self.cover = cover
        self.summary = summary
        self.platform = platform
        self.rate = rate
    }
    
    var gameDescriptionFields: [(UITableView,IndexPath) -> UITableViewCell] {
        return [
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellNamePhoto(tableView: tableView, indexPath: indexPath)!
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
                self.getCellPlatform(tableView: tableView, indexPath: indexPath)
                
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellRate(tableView: tableView, indexPath: indexPath)
                
            }
        ]
    }
}

extension Game {
    func getCellForTableViewController(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GameCellTableViewCell
        cell?.name?.text = name
        cell?.company?.text = company
        cell?.years?.text = firstReleaseDate
        cell?.cover?.image = cover
        return cell
    }
    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, game: Game) {
        navigationController.pushViewController(GameDescriptionTableViewController(game: game), animated: true)
    }
    func getCellNamePhoto(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: NamePhotoTableViewCell.namePhotoTableViewCellIdentifier, for: indexPath) as? NamePhotoTableViewCell
        cell?.selectionStyle = .none
        cell?.name?.text = name
        cell?.thumbnail?.image = cover
        return cell
    }
    func getCellSummary(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.summaryTableViewCellIdentifier, for: indexPath) as? SummaryTableViewCell
        cell?.selectionStyle = .none
        cell?.summary?.text = summary
        return cell!
    }
    func getCellCompany(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.companyTableViewCellIdentifier, for: indexPath) as? CompanyTableViewCell
        cell?.selectionStyle = .none
        cell?.company?.text = company
        return cell!
    }
    func getCellPublished(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.publishedTableViewCellIdentifier, for: indexPath) as? PublishedTableViewCell
        cell?.selectionStyle = .none
        cell?.firstReleaseDate?.text = firstReleaseDate
        return cell!
    }
    func getCellPlatform(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlatformTableViewCell.platformTableViewCellIdentifier, for: indexPath) as? PlatformTableViewCell
        cell?.selectionStyle = .none
        cell?.platform?.text = platform
        return cell!
    }
    func getCellRate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.ratingTableViewCellIdentifier, for: indexPath) as? RatingTableViewCell
        cell?.selectionStyle = .none
        cell?.rate?.text = rate
        return cell!
    }
}

struct Developers {
    static var fromSoftware: String { return "From Software" }
    static var cdProjectRed: String { return "CD Project Red" }
    static var rockStarNorth: String { return "Rockstar North" }
    static var helloGames: String { return "Hello Games" }
    static var nintendo: String { return "Nintendo" }
    
}

func heightRowInGameDescription(indexPath: Int) -> CGFloat {
    switch indexPath {
    case 0:
        return 110
    case 1:
        return 250
    case 2:
        return 30
    case 3:
        return 30
    case 4:
        return 30
    case 5:
        return 30
    default:
        return 0
    }
}

