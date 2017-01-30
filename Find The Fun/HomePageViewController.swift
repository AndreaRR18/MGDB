import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var showList: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.titleView = nil
        tabBarController?.navigationItem.title = "About"
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        self.view.backgroundColor = ColorUI.background
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

