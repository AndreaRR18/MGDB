import UIKit

class ScreenshotsViewController: UIViewController {
    
    @IBOutlet weak var screenshotsScrollView: UIScrollView?
    var screenshotsArray = [UIImageView]()
    var screenshotsURLs: [Screenshots]?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var screenshot = UIImageView()
    var screenShotTimer: Timer!
    
    required init(screenshotsURLs: [Screenshots]?) {
        self.screenshotsURLs = screenshotsURLs
        super.init(nibName: "ScreenshotsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Screenshots"
        view.backgroundColor = ColorUI.backgoundTableView
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let deadlineTime = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            for i in 0..<self.screenshotsArray.count {
                let imageView = UIImageView()
                imageView.image = self.screenshotsArray[i].image
                imageView.contentMode = .scaleAspectFit
                let xPosition = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition, y: 0, width: (self.screenshotsScrollView?.frame.width)!, height: (self.screenshotsScrollView?.frame.height)!)
                
                self.screenshotsScrollView?.contentSize.width = (self.screenshotsScrollView?.frame.width)! * CGFloat(i + 1)
                self.screenshotsScrollView?.addSubview(imageView)
            }
            self.activityIndicator.stopAnimating()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let screenshotsURLs = screenshotsURLs else { return }
        let deadlineTime = DispatchTime.now() + .seconds(2)
        for i in 0..<screenshotsURLs.count {
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.getScreenshotFromURL(url: screenshotsURLs[i].url!)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getScreenshotFromURL(url: String) {
        if let urlScreenshot = getScreenshots(url: url) {
            screenshot.af_setImage(
                withURL: urlScreenshot,
                imageTransition: .crossDissolve(0.3),
                runImageTransitionIfCached: true,
                completion: { _ in
                    self.screenshotsArray.append(self.screenshot)
            })
        }
    }
}
