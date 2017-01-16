import UIKit

class HomePageViewController: UIViewController {
    
    let igdbURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/genres/12?fields=*"
    var games = [Game]()
    
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

