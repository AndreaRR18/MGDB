import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let tabBarController = UITabBarController()
        let newsViewGameTableViewController = GameTableViewController()
        newsViewGameTableViewController.tabBarItem = UITabBarItem(title: "Novità", image: nil, tag: 0)
        let aboutViewGameTableViewController = HomePageViewController()
        aboutViewGameTableViewController.tabBarItem = UITabBarItem(title: "About", image: nil, tag: 1)
        let elementTabBarController = [newsViewGameTableViewController, aboutViewGameTableViewController]
        tabBarController.viewControllers = elementTabBarController
        tabBarController.navigationController?.navigationBar.isTranslucent = false


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()        
    }
}

