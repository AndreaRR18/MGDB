import UIKit

class HomePageViewController: UIViewController {
    
    init() {
        super.init(nibName: "HomepageViewController", bundle: nil)
    }
    @IBAction func Search(_ sender: Any) {
    navigationController?.pushViewController(GameTableViewController(), animated: true)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

}

