import UIKit

class HomePageViewController: UIViewController {
    
    @IBAction func showList(_ sender: Any) {
        
        let tabBarController = UITabBarController()
        let tabViewGameTableViewController = GameTableViewController()
        tabViewGameTableViewController.tabBarItem = UITabBarItem(title: "Novità", image: nil, tag: 0)
        let elementTabBarController = [tabViewGameTableViewController]
        tabBarController.viewControllers = elementTabBarController
        navigationController?.pushViewController(tabBarController, animated: false)
    }
    
    @IBOutlet weak var showList: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

