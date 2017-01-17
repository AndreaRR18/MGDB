import Foundation
import UIKit

class TabBarController: UIViewController {
    
    override func viewDidLoad() {
        let tabBarController = UITabBarController()
        let tabViewGameTableViewController = GameTableViewController()
        tabViewGameTableViewController.tabBarItem = UITabBarItem(title: "Novità", image: #imageLiteral(resourceName: "Find the Fun2"), tag: 0)
        let elementTabBarController = [tabViewGameTableViewController]
        tabBarController.viewControllers = elementTabBarController
        

    }

}
