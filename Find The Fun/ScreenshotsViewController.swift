//
//  ScreenshotsViewController.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 31/01/17.
//  Copyright © 2017 Andrea. All rights reserved.
//

import UIKit

class ScreenshotsViewController: UIViewController {

    @IBOutlet weak var screenshotsScrollView: UIScrollView?
    var screenshotsArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        screenshotsArray = [#imageLiteral(resourceName: "iconFTF"), #imageLiteral(resourceName: "ufo"), #imageLiteral(resourceName: "FTFLaunchingimage")]
        
        for i in 0..<screenshotsArray.count {
            let imageView = UIImageView()
            imageView.image = screenshotsArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: (self.screenshotsScrollView?.frame.width)!, height: (self.screenshotsScrollView?.frame.height)!)
            
            screenshotsScrollView?.contentSize.width = (screenshotsScrollView?.frame.width)! * CGFloat(i + 1)
            screenshotsScrollView?.addSubview(imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
