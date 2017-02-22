import Foundation
import UIKit

//------------Cell Builder-------------

extension Game {
    
    //--------------------Cell of First UITableView -------------------//
    func getCellForTableViewController(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GameCellTableViewCell
        cell.backgroundColor = ColorUI.background
        cell.name?.textColor = ColorUI.text
        cell.years?.textColor = ColorUI.text
        cell.cover?.layer.cornerRadius = 30.0
        cell.cover?.clipsToBounds = true
        cell.name?.text = name
        cell.years?.text = releaseDate?.first?.year.map(String.init)
        cell.url = getUrlHttps(url: cover?.url)
        return cell
    }
    
    //--------------------Cell of Description UITableView -------------------//
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
                self.getCellRate(tableView: tableView, indexPath: indexPath)
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
            {
                (tableView, indexPath) -> UITableViewCell in
                self.getCellVideos(tableView: tableView, indexPath: indexPath)
            }
        ]
    }
    
    func getCellCoverHD(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoverHDTableViewCell.coverHDTableViewCellIdentifier, for: indexPath) as! CoverHDTableViewCell
        cell.url = getHDImage(url: cover?.url)
        return cell
    }
    
    func getCellCover(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoverTableViewCell.coverTableViewCellIdentifier, for: indexPath) as! CoverTableViewCell
        cell.url = getHDImage(url: cover?.url)
        cell.name?.text = name
        cell.layer.zPosition = 3
        return cell
    }
    
    func getCellSummary(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.summaryTableViewCellIdentifier, for: indexPath) as! SummaryTableViewCell
        cell.backgroundColor = ColorUI.background
        cell.isSelected = false
        cell.summaryText?.textColor = ColorUI.text
        cell.summaryText?.text = summary
        return cell
    }
    func getCellCompany(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.companyTableViewCellIdentifier, for: indexPath) as! CompanyTableViewCell
        cell.backgroundColor = ColorUI.background
        cell.company?.textColor = ColorUI.text
        if let developers = developers {
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
    }
    
    func getCellPublished(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.publishedTableViewCellIdentifier, for: indexPath) as! PublishedTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.backgroundColor = ColorUI.background
        cell.firstReleaseDate?.textColor = ColorUI.text
        return cell
    }
    
    func getCellRate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.ratingTableViewCellIdentifier, for: indexPath) as! RatingTableViewCell
        cell.backgroundColor = ColorUI.background
        cell.rate?.textColor = ColorUI.text
        cell.rate?.text = rating.map(String.init) ?? "N.D."
        return cell
    }
    
    func getCellGenres(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.genresTableViewCellIdentifier, for: indexPath) as! GenreTableViewCell
        cell.backgroundColor = ColorUI.background
        cell.genres?.textColor = ColorUI.text
        nameGenresDB(id: genres, callback: { nameGenre in
            cell.genres?.text = nameGenre
        })
        return cell
    }
    func getCellGameModes(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameModesTableViewCell.gameModesTableViewCellIdentifier, for: indexPath) as! GameModesTableViewCell
        
        cell.backgroundColor = ColorUI.background
        cell.gameModes?.textColor = ColorUI.text
        nameGameModesDB(id: gameModes, callback: { nameGameModes in
            cell.gameModes?.text = nameGameModes
        })
        return cell
    }
    
    func getCellRelatedInDescription(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RelatedInDescriptionTableViewCell.relatedInDescriptionTableViewCellIdentifier, for: indexPath) as! RelatedInDescriptionTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.backgroundColor = ColorUI.background
        return cell
    }
    
    func getCellScreenshots(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScreenshotsTableViewCell.screenshotsTableViewCellIdentifier, for: indexPath) as! ScreenshotsTableViewCell
        cell.backgroundColor = ColorUI.background
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func getCellVideos(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideosTableViewCell.videosTableViewCellIdentifier, for: indexPath) as! VideosTableViewCell
        cell.backgroundColor = ColorUI.background
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, game: Game) {
        navigationController.pushViewController(GameDescriptionTableViewController(game: game), animated: true)
    }
    
    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        switch indexPath.row {
        case 1:
            navigationController.navigationBar.isTranslucent = false
            navigationController.pushViewController(CoverViewController(coverURL: cover?.url), animated: true)
        case 4:
            navigationController.navigationBar.isTranslucent = false
            navigationController.pushViewController(ReleaseDateTableViewController(arrayReleaseDate: releaseDate), animated: true)
        case 8:
            navigationController.navigationBar.isTranslucent = false
            if let screenshots = screenshots {
                navigationController.pushViewController(ScreenshotsCollectionViewController(arrayScreenshots: screenshots), animated: true)
//                navigationController.pushViewController(ScreenshotTableViewController(arrayScreenshots: screenshots), animated: true)
            } else {
                let alert = Alert(title: "Sorry", message: "Screenshots not found!")
                navigationController.present(alert.alertControllerLaunch(), animated: true, completion: nil)
            }
        case 9:
            navigationController.navigationBar.isTranslucent = false
            if let genres = genres {
                navigationController.pushViewController(RelatedTableViewController(idGenres: genres), animated: true)
            } else {
                let alert = Alert(title: "Sorry", message: "Related games not found!")
                navigationController.present(alert.alertControllerLaunch(), animated: true, completion: nil)
            }
            
        case 10:
            navigationController.navigationBar.isTranslucent = false
            if let videos = videos {
                navigationController.pushViewController(VideosTableViewController(videos: videos), animated: true)
            } else {
                let alert = Alert(title: "Sorry", message: "Video not found!")
                navigationController.present(alert.alertControllerLaunch(), animated: true, completion: nil)
            }
        default:
            return
        }
    }
}


