import UIKit

struct ActivityIndicator {
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let activityIndicatorFooter = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private let view: UIView?
    private let background: UIColor
    private let activityIndicatorColor: UIColor
    private let withBackground: Bool
    private let loadingBackground: UIView = UIView()
    
    init(view: UIView?, background: UIColor = UIColor.white, activityIndicatorColor: UIColor = UIColor.gray, withBackground: Bool = false) {
        self.view = view
        self.background = background
        self.activityIndicatorColor = activityIndicatorColor
        self.withBackground = withBackground
    }
    
    
    func startAnimating() {
        guard let view = view else { return }
        
        if withBackground {
            loadingBackground.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingBackground.center = view.center
            loadingBackground.backgroundColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.5)
            loadingBackground.clipsToBounds = true
            loadingBackground.layer.cornerRadius = 10
            
            view.addSubview(loadingBackground)
        }
        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.backgroundColor = UIColor.white
        activityIndicator.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        activityIndicator.backgroundColor = background
        activityIndicator.color = activityIndicatorColor
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    
    func stopAnimating() {
        loadingBackground.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    
    static func activityIndicatorFooterView(_ view: UIView) -> UIView {
        let footerView = UIView(frame:
            CGRect.init(
                x: 0,
                y: 0,
                width: Int(view.frame.width),
                height: 30))
        
        footerView.backgroundColor = UIColor.white
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        footerView.addSubview(activityView)
        
        activityView.startAnimating()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: activityView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        NSLayoutConstraint(
            item: activityView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        return footerView
    }
}
