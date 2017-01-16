import Foundation
import UIKit

struct Game {
    let name: String?
    let genres: String?
    let firstReleaseDate: String?
    let company: String?
    let cover: UIImage
    let identifier = GameCellTableViewCell.cellGameCellIdentifier
    
    init(name: String, genres: String, firstReleaseDate: String, company: String, cover: UIImage) {
        self.name = name
        self.genres = genres
        self.firstReleaseDate = firstReleaseDate
        self.company = company
        self.cover = cover
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GameCellTableViewCell
        cell?.selectionStyle = .none
        cell?.name?.text = name
        cell?.categories?.text = genres
        cell?.company?.text = company
        cell?.years?.text = firstReleaseDate
        cell?.cover?.image = cover
        return cell
    }
}

struct GameDescription {
    let name: String?
    let cover: UIImage?
    let summary: String?
    let company: String?
    
}

enum Genres: String {
    case rolePlaying = "Role-Playing"
    case adventure = "Adventure"
    case shooter = "Shooter"
    case platform = "Platform"
}

enum Developers: String {
    case fromSoftware = "From Software"
    case cdProjectRed = "CD Project Red"
    case rockStarNorth = "Rockstar North"
    case helloGames = "Hello Games"
    case nintendo = "Nintendo"
}


