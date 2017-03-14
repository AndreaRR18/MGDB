import UIKit

class About: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == true {
            
            navigationController?.setNavigationBarHidden(false, animated: animated)
            
        }
        
        navigationItem.title = "About"
        
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]
        
        navigationController?.navigationBar.barTintColor = ColorUI.navBar
        
        tabBarController?.tabBar.isTranslucent = false
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

