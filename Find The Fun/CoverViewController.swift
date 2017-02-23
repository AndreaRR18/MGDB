import UIKit

class CoverViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var doneButton: UIButton?
    @IBOutlet weak var coverHighResolution: UIImageView?
    @IBOutlet weak var coverScrollView: UIScrollView?
    
    @IBAction func doneButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var coverURL: String?
    var imageZoom = false
    
    required init(coverURL: String?) {
        super.init(nibName: "CoverViewController", bundle: nil)
        self.coverURL = coverURL
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        swipeDown.delegate = self
        self.view.addGestureRecognizer(swipeDown)
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
  
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return true
    }
    
    func respondSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer, imageZoom {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.down:
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
}

extension CoverViewController: UIScrollViewDelegate {
    
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            if scrollView.zoomScale == 1 {
                imageZoom = true
            } else {
                imageZoom = false
            }
        }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.coverHighResolution
    }
}



