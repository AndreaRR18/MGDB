import Foundation
import UIKit

protocol CellFactory {
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

// MARK: - Name and Photo header

class NamePhoto: CellFactory {
    let name: String?
    let thumbnail: UIImage?
    
    init(name: String, thumbnail: UIImage) {
        self.name = name
        self.thumbnail = thumbnail
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NamePhotoTableViewCell.namePhotoTableViewCellIdentifier, for: indexPath) as? NamePhotoTableViewCell
        cell?.name?.text = name
        cell?.thumbnail?.image = thumbnail
        return cell!
    }
}

// MARK: - Summary

class Summary: CellFactory {
    let summary: String?
    
    init(summary: String) {
        self.summary = summary
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.summaryTableViewCellIdentifier, for: indexPath) as? SummaryTableViewCell
        cell?.summary?.text = summary
        return cell!
    }
}

// MARK: - Company

class Company: CellFactory {
    let company: String?
    
    init(company: String) {
        self.company = company
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.companyTableViewCellIdentifier, for: indexPath) as? CompanyTableViewCell
        cell?.company?.text = company
        return cell!
    }
}


// MARK: - Published

class Published: CellFactory {
    let published: String?
    
    init(published: String) {
        self.published = published
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.publishedTableViewCellIdentifier, for: indexPath) as? PublishedTableViewCell
        cell?.firstReleaseDate?.text = published
        return cell!
    }
}

// MARK: - Platform

class Platform: CellFactory {
    let platform: String
    
    init(platform: String) {
        self.platform = platform
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlatformTableViewCell.platformTableViewCellIdentifier, for: indexPath) as? PlatformTableViewCell
        cell?.platform?.text = platform
        return cell!
    }
}

// MARK: - Gnres

class Gnres: CellFactory {
    let gnres: String
    
    init(gnres: String) {
        self.gnres = gnres
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GnresTableViewCell.gnresTableViewCellIdentifier, for: indexPath) as? GnresTableViewCell
        cell?.gnres?.text = gnres
        return cell!
    }
}


// MARK: - Rating

class Rating: CellFactory {
    let rate: String
    
    init(rate: String) {
        self.rate = rate
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.ratingTableViewCellIdentifier, for: indexPath) as? RatingTableViewCell
        cell?.rate?.text = rate
        return cell!
    }
}















