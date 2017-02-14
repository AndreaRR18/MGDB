import Foundation
import UIKit

class Alert {
    let title: String?
    let message: String?
    
    init(title: String?, message: String?) {
        self.title = title
        self.message = message
    }
    
    func alertControllerLaunch() -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        return alertController
    }
}
