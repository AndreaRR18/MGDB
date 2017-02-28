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
        return 200
    case 8:
        return 60
    case 9:
        return 200
    default:
        return 0
    }
}
