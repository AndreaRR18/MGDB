import UIKit

//let offset_HeaderStop: CGFloat = 40.0
//let offset_B_LabelHeader: CGFloat = 95.0
//let distance_W_LabelHeader: CGFloat = 35.0

class DescriptionGameViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var header: UIView?
    @IBOutlet weak var headerLabel: UILabel?
    @IBOutlet weak var headerImageView: UIImageView?
    @IBOutlet weak var headerBlurImageView: UIImageView?
    var blurredHeaderImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        headerImageView = UIImageView(frame: (header?.bounds)!)
        headerImageView?.image = #imageLiteral(resourceName: "header_bg")
        headerImageView?.contentMode = UIViewContentMode.scaleAspectFill
        guard let headerLabel = headerLabel, let header = header, let headerImageView = headerImageView else { return }
        header.insertSubview(headerImageView, belowSubview: headerLabel)
        
        headerBlurImageView = UIImageView(frame: header.bounds)
        headerBlurImageView?.image = #imageLiteral(resourceName: "header_bg")
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = header.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerBlurImageView?.addSubview(blurEffectView)
        headerBlurImageView?.contentMode = UIViewContentMode.scaleAspectFill
        headerBlurImageView?.alpha = 0.0
        header.insertSubview(headerBlurImageView!, belowSubview: headerLabel)
        header.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        guard let header = header, let cover = cover else { return }
        // Pull down --------------------
        if offset < 0 {
            let headerScaleFactor: CGFloat = -(offset) / header.bounds.height
            let headerSizeVariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height) / 2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizeVariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            header.layer.transform = headerTransform
            
            //scroll up/down ---------------
        } else {
            
            //header ----------------
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //------------------- label
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
            headerLabel?.layer.transform = labelTransform
            
            //------------------- blur
            headerBlurImageView?.alpha = min(1.0, (offset - offset_B_LabelHeader) / distance_W_LabelHeader)
            
            // avatar --------------
            let coverScaleFactor = (min(offset_HeaderStop, offset)) / cover.bounds.height / 1.4
            let coverSizeVariation = ((cover.bounds.height * (1.0 + coverScaleFactor)) - cover.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, coverSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - coverScaleFactor, 1.0 - coverScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                if cover.layer.zPosition < header.layer.zPosition {
                    header.layer.zPosition = 0
                }
            } else {
                if cover.layer.zPosition >= header.layer.zPosition {
                    header.layer.zPosition = 2
                }
            }
        }
        
        header.layer.transform = headerTransform
        cover.layer.transform = avatarTransform
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
