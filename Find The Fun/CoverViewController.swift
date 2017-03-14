import UIKit

class CoverViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var doneButton: UIButton?
    
    @IBOutlet weak var coverHighResolution: UIImageView?
    
    @IBOutlet weak var coverScrollView: UIScrollView?
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        guard let coverHighResolution = coverHighResolution?.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(
            coverHighResolution,
            self,
            #selector(CoverViewController.image(_:didFinishSavingWithError:contextInfo:)),
            nil)
    
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        
        self.dismiss(
            animated: true,
            completion: nil)
    
    }
    
    private var coverURL: String?
    
    private var imageZoom = false
    
    
    required init(coverURL: String?) {
        
        super.init(nibName: "CoverViewController", bundle: nil)
        
        self.coverURL = coverURL
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let swipeDown = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.respondSwipeGesture(gesture:)))
        
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        
        swipeDown.delegate = self
        
        self.view.addGestureRecognizer(swipeDown)
        
        view.backgroundColor = UIColor.black
        
        let activityIndicator = ActivityIndicator(
            view: view,
            background: UIColor.black,
            activityIndicatorColor: UIColor.white)
        
        activityIndicator.startAnimating()
        
        coverScrollView?.maximumZoomScale = 4.0
        
        coverScrollView?.minimumZoomScale = 1.0
        
        coverScrollView?.alwaysBounceVertical = true
       
        if let urlExist = GetUrl.getCover(url: coverURL) {
            
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
                
                view.backgroundColor = UIColor.clear
                
                self.dismiss(animated: true, completion: nil)
            
            default:
               
                break
            
            }
        
        }
    
    }
    
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        guard  let coverHighResolution = coverHighResolution else { return }
        
        let activityIndicator = ActivityIndicator(view: coverHighResolution)
        
        if let error = error {
            
            activityIndicator.startAnimating()
            
            let ac = UIAlertController(
                title: "Save error",
                message: error.localizedDescription,
                preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            
            present(
                ac,
                animated: true,
                completion: {
                
                    activityIndicator.stopAnimating()
            
            })
        
        } else {
            
            activityIndicator.startAnimating()
            
            let ac = UIAlertController(
                title: "Saved!",
                message: nil,
                preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            
            present(
                ac,
                animated: true,
                completion: {
                    
                activityIndicator.stopAnimating()
            
            })
        
        }
    
    }
    
    
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




