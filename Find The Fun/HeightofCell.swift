import Foundation
import UIKit

func heightRowInGameDescription(indexPath: Int) -> CGFloat {
    switch indexPath {
    case 0:
        return 100
    case 1:
        return 90
    case 2:
        return 200
    case 3:
        return 60
    case 4:
        return 60
    case 5:
        return 60
    case 6:
        return 60
    case 7:
        return 150
    case 8:
        return 60
    case 9:
        return 160
    default:
        return 0
    }
}

func developersRowHeight (_ numberOfDevelopers: Int) -> CGFloat {
    let height = 55
    let heightLabel = 45
    return  CGFloat((heightLabel * numberOfDevelopers) + height)
}

func heightSummary(_ numberOfCharacters: Int) -> CGFloat {
    if numberOfCharacters < 50 {
        return 40
    } else if numberOfCharacters < 100 {
        return 80
    } else if numberOfCharacters < 150 {
        return 120
    } else if numberOfCharacters < 200 {
        return 160
    } else if numberOfCharacters < 250 {
        return 200
    } else if numberOfCharacters < 300 {
        return 240
    } else if numberOfCharacters < 350 {
        return 280
    } else if numberOfCharacters < 400 {
        return 320
    } else if numberOfCharacters < 450 {
        return 360
    } else if numberOfCharacters < 500 {
        return 400
    } else if numberOfCharacters < 550 {
        return 440
    } else if numberOfCharacters < 600 {
        return 480
    } else {
        return 520
    }
}

func heightSectionDescription(_ section: Int,_ game: Game) -> CGFloat {
    switch section {
    case 9:
        return 0
    case 0:
        return 0
    case 1:
        guard game.summary != nil  else { return 0 }
        return 35
    case 2:
        guard let developers = game.developers, developers.count > 0 else { return 0 }
        return 35
    case 3:
        guard let publishers = game.publishers, publishers.count > 0  else { return 0 }
        return 35
    case 4:
        guard let releaseDate = game.releaseDate, releaseDate.count > 0 else { return 0 }
        return 35
    case 5:
        guard let genres = game.genres, genres.count > 0 else { return 0 }
        return 35
    case 6:
        guard let gameModes = game.gameModes, gameModes.count > 0 else { return 0 }
        return 35
    case 7:
        guard let screenshots = game.screenshots, screenshots.count > 0 else { return 0 }
        return 35
    case 8:
        guard let videos = game.videos, videos.count > 0 else { return 0 }
        return 35
    default:
        return 0
    }
}
