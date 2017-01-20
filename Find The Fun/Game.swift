import Foundation
import UIKit
import Runes
import Argo
import Curry

struct Game {
    //required
    let idGame: Int   //id
    let name: String  //name
    
    //optional
    let summary: String? //summary
    let rating: Int? //rating
    let developers: [Int]? //developers
    let releaseDate: [ReleaseDate]?  //release_dates
    
    let identifier = GameCellTableViewCell.cellGameCellIdentifier
}

extension Game: Decodable {
    static func decode(_ json: JSON) -> Decoded<Game> {
        return curry(Game.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <|? "summary"
            <*> json <|? "rating"
            <*> json <||? "developers"
            <*> json <||? "release_dates"
    }
}

struct ReleaseDate {
    let platform: String?
    let year: Int?
    let month: Int?
}

extension ReleaseDate: Decodable {
    static func decode(_ json: JSON) -> Decoded<ReleaseDate> {
        return curry(ReleaseDate.init)
        <^> json <|? "platform"
        <*> json <|? "y"
        <*> json <|? "m"
    }
}


extension Game {
    
    //--------------------Cell of First UITableView -------------------//
    func getCellForTableViewController(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GameCellTableViewCell
        cell?.name?.text = name
        cell?.company?.text = developers?.first.map(String.init)
        cell?.years?.text = releaseDate?.first?.year.map(String.init)
        return cell
    }
    
    //--------------------Cell of Description UITableView -------------------//
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
    
    func getCellNamePhoto(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: NamePhotoTableViewCell.namePhotoTableViewCellIdentifier, for: indexPath) as? NamePhotoTableViewCell
        cell?.selectionStyle = .none
        cell?.name?.text = name
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
        cell?.company?.text = developers?.first.map(String.init)
        return cell!
    }
    func getCellPublished(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.publishedTableViewCellIdentifier, for: indexPath) as? PublishedTableViewCell
        cell?.selectionStyle = .none
        cell?.firstReleaseDate?.text = releaseDate?.first?.year.map(String.init)
        return cell!
    }
    func getCellPlatform(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlatformTableViewCell.platformTableViewCellIdentifier, for: indexPath) as? PlatformTableViewCell
        cell?.selectionStyle = .none
        cell?.platform?.text = releaseDate?.first?.platform
        return cell!
    }
    func getCellRate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.ratingTableViewCellIdentifier, for: indexPath) as? RatingTableViewCell
        cell?.selectionStyle = .none
        cell?.rate?.text = rating.map(String.init)
        return cell!
    }
    
    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, game: Game) {
        navigationController.pushViewController(GameDescriptionTableViewController(game: game), animated: true)
    }
}


func heightRowInGameDescription(indexPath: Int) -> CGFloat {
    switch indexPath {
    case 0:
        return 110
    case 1:
        return 210
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

