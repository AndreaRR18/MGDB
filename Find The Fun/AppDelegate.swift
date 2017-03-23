import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        let tabBarController = UITabBarController()
        
        let navControllerGameTableViewController = UINavigationController(rootViewController: GameTableViewController())
        
        navControllerGameTableViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: #imageLiteral(resourceName: "home 30x30"),
            tag: 0)
        
        let navControllerSearchGameTableViewController = UINavigationController(rootViewController: SearchGamesTableViewController())
        
        navControllerSearchGameTableViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: #imageLiteral(resourceName: "searching 30x30"),
            tag: 1)

        let navControllerFavouriteGameTableViewController = UINavigationController(rootViewController: FavouriteCollectionViewController())
        
        navControllerFavouriteGameTableViewController.tabBarItem = UITabBarItem(
            title: "Favourite",
            image: #imageLiteral(resourceName: "star 30x30"),
            tag: 2)

        let elementTabBarController = [navControllerGameTableViewController, navControllerSearchGameTableViewController, navControllerFavouriteGameTableViewController]

        tabBarController.viewControllers = elementTabBarController
        tabBarController.navigationController?.navigationBar.isTranslucent = false
        tabBarController.navigationController?.navigationBar.isOpaque = false
        tabBarController.navigationController?.navigationBar.tintColor = ColorUI.text
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        DatabaseController.saveContext()
    }
    
}
