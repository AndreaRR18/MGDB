import UIKit


class CoverViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var coverHighResolution: UIImageView?
    @IBOutlet weak var coverScrollView: UIScrollView?
    var coverURL: String?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    required init(coverURL: String?) {
        super.init(nibName: "CoverViewController", bundle: nil)
        self.coverURL = coverURL
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ColorUI.backgoundTableView
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        if let urlExist = getCover(url: coverURL) {
            coverHighResolution?.af_setImage(
                withURL: urlExist,
                imageTransition: .crossDissolve(0.3),
                runImageTransitionIfCached: true,
                completion: { _ in
                    self.activityIndicator.stopAnimating() })
        }
        self.coverScrollView?.isScrollEnabled = true
        self.coverHighResolution?.isUserInteractionEnabled = true
        self.coverScrollView?.minimumZoomScale = 1.0
        self.coverScrollView?.maximumZoomScale = 6.0
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.coverHighResolution
    }
}
