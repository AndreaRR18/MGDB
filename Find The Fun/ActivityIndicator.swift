import UIKit

struct ActivityIndicator {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let activityIndicatorFooter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    func startAnimating() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.backgroundColor = UIColor.white
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
}
