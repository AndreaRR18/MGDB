import Foundation
import UIKit

//------------Cell Builder-------------

extension Game {
    
    //--------------------Cell of First UITableView -------------------//
//    func getCellForTableViewController(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameCellTableViewCell, for: indexPath) as! GameCellTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.name?.textColor = ColorUI.text
//        cell.years?.textColor = ColorUI.text
//        cell.cover?.clipsToBounds = true
//        cell.name?.text = name
//        cell.years?.text = releaseDate?.first?.year.map(String.init)
//        cell.rating = Float(rating ?? 1)
//        cell.url = getCoverSmall(url: cover?.url)
//        return cell
//    }
    
    //--------------------Cell of Description UITableView -------------------//
//    var gameDescriptionFields: [(UITableView,IndexPath, GameDescriptionTableViewController) -> UITableViewCell] {
//        return [
//            { (tableView, indexPath,tableViewController) -> UITableViewCell in
//                self.getCellCoverHD(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellCover(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellSummary(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellCompany(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellPublished(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellGenres(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellGameModes(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellScreenshots(tableView: tableView, indexPath: indexPath, tableViewController: tableViewController)
//            },
//            { (tableView,indexPath,tableViewController) -> UITableViewCell in
//                self.getCellRelatedInDescription(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView, indexPath,tableViewController) -> UITableViewCell in
//                self.getCellVideos(tableView: tableView, indexPath: indexPath, tableViewController: tableViewController)
//            }
//        ]
//    }
//    
//    func getCellCoverHD(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverHDTableViewCell, for: indexPath) as! CoverHDTableViewCell
//        cell.url = getHDImage(url: cover?.url)
//        return cell
//    }
//    
//    func getCellCover(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
//        cell.url = getCoverMed(url: cover?.url)
//        cell.name?.text = name
//        cell.rating = Float(rating ?? 1)
//        cell.layer.zPosition = 3
//        return cell
//    }
//    
//    func getCellSummary(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.summaryTableViewCell, for: indexPath) as! SummaryTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.isSelected = false
//        cell.textSummary = summary
//        cell.summaryText?.textColor = ColorUI.text
//        return cell
//    }
//    func getCellCompany(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.company?.textColor = ColorUI.text
//        if let developers = developers {
//            nameCompanyDB(id: developers, callback: { nameCompany, new in
//                cell.company?.text = nameCompany
//                if new {
//                    _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
//                        tableView.reloadData()
//                    })
//                }
//            })
//        } else {
//            cell.company?.text = "N.D."
//        }
//        return cell
//    }
//    
//    func getCellPublished(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.publishedTableViewCell, for: indexPath) as! PublishedTableViewCell
//        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        cell.backgroundColor = ColorUI.background
//        cell.firstReleaseDate?.textColor = ColorUI.text
//        return cell
//    }
//    
//    func getCellRate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.ratingTableViewCell, for: indexPath) as! RatingTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.rate?.textColor = ColorUI.text
//        cell.rate?.text = rating.map(String.init) ?? "N.D."
//        return cell
//    }
//    
//    func getCellGenres(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.genres?.textColor = ColorUI.text
//        nameGenreDB(id: genres, callback: { nameGenre in
//            cell.genres?.text = nameGenre
//        })
//        return cell
//    }
//    func getCellGameModes(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.gameModes?.textColor = ColorUI.text
//        nameGameModeDB(id: gameModes, callback: { nameGameModes in
//            cell.gameModes?.text = nameGameModes
//        })
//        return cell
//    }
//    
//    func getCellRelatedInDescription(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.relatedInDescriptionTableViewCell, for: indexPath) as! RelatedInDescriptionTableViewCell
//        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        cell.backgroundColor = ColorUI.background
//        return cell
//    }
//    
//    func getCellScreenshots(tableView: UITableView, indexPath: IndexPath, tableViewController: GameDescriptionTableViewController) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.screenshotsCollectionTableViewCell, for: indexPath) as! ScreenshotCollectionTableViewCell
//        guard let screenshots = screenshots else { return cell }
//        cell.screenshot = screenshots
//        cell.delegate = tableViewController
//        return cell
//    }
//    
//    func getCellVideos(tableView: UITableView, indexPath: IndexPath, tableViewController: GameDescriptionTableViewController) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.videoCollectionTableViewCell, for: indexPath) as! VideoCollectionTableViewCell
//        guard let videos = videos else { return cell }
//        cell.video = videos
//        cell.delegate = tableViewController
//        return cell
//    }

    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, game: Game) {
        navigationController.pushViewController(DescriptionViewController(game: game), animated: true)
    }
//    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, game: Game) {
//        navigationController.pushViewController(GameDescriptionTableViewController(game: game), animated: true)
//    }
    
//    func didSelectGameWithTabBar(tableView: UITableView, indexPath: IndexPath, tabBarController: UITabBarController, game: Game) {
//        tabBarController.navigationController?.pushViewController(GameDescriptionTableViewController(game: game), animated: true)
//    }
    
    func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        switch indexPath.row {
        case 1:
            navigationController.present(CoverViewController(coverURL: cover?.url), animated: true, completion: nil)
        case 4:
            navigationController.navigationBar.isTranslucent = false
            navigationController.pushViewController(ReleaseDateTableViewController(arrayReleaseDate: releaseDate), animated: true)
        case 8:
            navigationController.navigationBar.isTranslucent = false
            if let genres = genres {
                navigationController.pushViewController(RelatedTableViewController(idGenres: genres), animated: true)
            } else {
                let alert = Alert(title: "Sorry", message: "Related games not found!")
                navigationController.present(alert.alertControllerLaunch(), animated: true, completion: nil)
            }
        default:
            return
        }
    }
    
//    var gameDescriptionCell: [(UITableView,IndexPath, DescriptionViewController, UIImageView?) -> UITableViewCell] {
//        return [
//            { (tableView, indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getDescriptionCellCoverHD(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getDescriptionCellCover(tableView: tableView, indexPath: indexPath, referenceImageView: referenceImageView)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getDescriptionCellSummary(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getDescriptionCellCompany(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getDescriptionCellPublished(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getDescriptionCellGenres(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getDescriptionCellGameModes(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getCellDescriptionScreenshots(tableView: tableView, indexPath: indexPath, viewController: viewController)
//            },
//            { (tableView,indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getCellDescriptionRelatedInDescription(tableView: tableView, indexPath: indexPath)
//            },
//            { (tableView, indexPath,viewController,referenceImageView) -> UITableViewCell in
//                self.getCellDescriptionVideos(tableView: tableView, indexPath: indexPath, viewController: viewController)
//            }
//        ]
//    }
//    
//    
//    func getDescriptionCellCoverHD(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverHDTableViewCell, for: indexPath) as! CoverHDTableViewCell
//        cell.backgroundColor = UIColor.clear
//        cell.coverHQ?.image = #imageLiteral(resourceName: "emptyBackground")
//        return cell
//    }
//    
//    func getDescriptionCellCover(tableView: UITableView, indexPath: IndexPath, referenceImageView: UIImageView?) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.coverTableViewCell, for: indexPath) as! CoverTableViewCell
//        var referenceView = referenceImageView
//        if referenceImageView == nil {
//            referenceView = cell.thumbnail
//        }
//        cell.url = getCoverMed(url: cover?.url)
//        cell.name?.text = name
//        cell.rating = Float(rating ?? 1)
//        cell.layer.zPosition = 3
//        return cell
//    }
//    
//    func getDescriptionCellSummary(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.summaryTableViewCell, for: indexPath) as! SummaryTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.isSelected = false
//        cell.textSummary = summary
//        cell.summaryText?.textColor = ColorUI.text
//        return cell
//    }
//    
//    func getDescriptionCellCompany(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.company?.textColor = ColorUI.text
//        if let developers = developers {
//            nameCompanyDB(id: developers, callback: { nameCompany, new in
//                cell.company?.text = nameCompany
//                if new {
//                    _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
//                        tableView.reloadData()
//                    })
//                }
//            })
//        } else {
//            cell.company?.text = "N.D."
//        }
//        return cell
//    }
//    func getDescriptionCellPublished(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.publishedTableViewCell, for: indexPath) as! PublishedTableViewCell
//        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        cell.backgroundColor = ColorUI.background
//        cell.firstReleaseDate?.textColor = ColorUI.text
//        return cell
//    }
//    func getDescriptionCellGenres(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.genres?.textColor = ColorUI.text
//        nameGenreDB(id: genres, callback: { nameGenre in
//            cell.genres?.text = nameGenre
//        })
//        return cell
//    }
//    func getDescriptionCellGameModes(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.gameModesTableViewCell, for: indexPath) as! GameModesTableViewCell
//        cell.backgroundColor = ColorUI.background
//        cell.gameModes?.textColor = ColorUI.text
//        nameGameModeDB(id: gameModes, callback: { nameGameModes in
//            cell.gameModes?.text = nameGameModes
//        })
//        return cell
//    }
//    func getCellDescriptionScreenshots(tableView: UITableView, indexPath: IndexPath, viewController: DescriptionViewController) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.screenshotsCollectionTableViewCell, for: indexPath) as! ScreenshotCollectionTableViewCell
//        guard let screenshots = screenshots else { return cell }
//        cell.screenshot = screenshots
//        return cell
//    }
//    func getCellDescriptionRelatedInDescription(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.relatedInDescriptionTableViewCell, for: indexPath) as! RelatedInDescriptionTableViewCell
//        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        cell.backgroundColor = ColorUI.background
//        return cell
//    }
//    func getCellDescriptionVideos(tableView: UITableView, indexPath: IndexPath, viewController: DescriptionViewController) -> UITableViewCell{
//        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.videoCollectionTableViewCell, for: indexPath) as! VideoCollectionTableViewCell
//        guard let videos = videos else { return cell }
//        cell.video = videos
//        return cell
//    }
//    
    
}


