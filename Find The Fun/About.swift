import UIKit

class About: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = "About"
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        tabBarController?.tabBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

