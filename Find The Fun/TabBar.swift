//import Foundation
//import UIKit
//
//class TabBar: UITabBarController {
//    
//    let newsViewGameTableViewController = GameTableViewController()
//    
//    let searchGameTableViewController = SearchGamesTableViewController()
//    
//    let favouriteGameTableViewController = FavouriteCollectionViewController()
//    
//    let aboutViewGameTableViewController = About()
//    
//    
//    func setTabBarController() -> [UIViewController] {
//    
//        tabBarController?
//            .navigationController?
//            .navigationBar
//            .isTranslucent = false
//        
//        tabBarController?
//            .navigationController?
//            .navigationBar
//            .isOpaque = false
//        
//        tabBarController?
//            .navigationController?
//            .navigationBar
//            .tintColor = ColorUI.text
//        
//        tabBarController?
//            .tabBar
//            .barTintColor = ColorUI.tabBar
//        
//        tabBarController?
//            .tabBar.tintColor = UIColor.white
//        
//        tabBarController?
//            .tabBar
//            .unselectedItemTintColor = ColorUI.unselectedItemTabBar
//        
//        newsViewGameTableViewController.tabBarItem = UITabBarItem(title: "News", image: #imageLiteral(resourceName: "news 40x40"), tag: 0)
//        
//        searchGameTableViewController.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search 30x30"), tag: 1)
//        
//        favouriteGameTableViewController.tabBarItem = UITabBarItem(title: "Favourite", image: #imageLiteral(resourceName: "favourites 40x40"), tag: 2)
//        
//        aboutViewGameTableViewController.tabBarItem = UITabBarItem(title: "About", image: #imageLiteral(resourceName: "about 30x30"), tag: 3)
//        
//        
//        let elementTabBarController = [newsViewGameTableViewController, searchGameTableViewController, favouriteGameTableViewController, aboutViewGameTableViewController]
//        
//        return elementTabBarController
//    
//    }
// 
//}
