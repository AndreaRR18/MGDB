import UIKit

class CoverViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton?
    @IBOutlet weak var coverHighResolution: UIImageView?
    @IBOutlet weak var coverScrollView: UIScrollView?
    
    @IBAction func doneButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var coverURL: String?
    
    required init(coverURL: String?) {
        super.init(nibName: "CoverViewController", bundle: nil)
        self.coverURL = coverURL
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        coverHighResolution?.backgroundColor = UIColor.black
        let activityIndicator = ActivityIndicator(view: view)
        activityIndicator.startAnimating()
        coverScrollView?.maximumZoomScale = 5.0
        coverScrollView?.minimumZoomScale = 1.0
        coverScrollView?.alwaysBounceVertical = true
        if let urlExist = getCover(url: coverURL) {
            coverHighResolution?.af_setImage(
                withURL: urlExist,
                imageTransition: .crossDissolve(0.1),
                runImageTransitionIfCached: true,
                completion: { _ in
                    activityIndicator.stopAnimating() })
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension CoverViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.y < view.frame.height / 2, scrollView.zoomScale == 1 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.coverHighResolution
    }
}



