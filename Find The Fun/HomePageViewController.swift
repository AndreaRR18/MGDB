import UIKit

class HomePageViewController: UIViewController {
    
    @IBAction func showList(_ sender: Any) {
        navigationController?.pushViewController(GameTableViewController(), animated: true)
    }
    
    @IBOutlet weak var showList: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

