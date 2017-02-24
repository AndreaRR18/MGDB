import Foundation
import UIKit

class TableViewSetting {
    
    let tableView: UITableView
    let tabBarController: UITabBarController?
    
    init(_ tableView: UITableView, _ tabBarController: UITabBarController?) {
        self.tableView = tableView
        self.tabBarController = tabBarController
        setTableView()
    }
    
    let viewFooter = UIView()
    
    private func setTableView() {
        viewFooter.backgroundColor = ColorUI.background
        tableView.tableFooterView = viewFooter
        tabBarController?.tabBar.barTintColor = ColorUI.tabBar
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.tintColor = UIColor.white
        tabBarController?.tabBar.unselectedItemTintColor = ColorUI.unselectedItemTabBar
    }
    
    
}
