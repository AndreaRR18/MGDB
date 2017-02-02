import Foundation
import UIKit


//class ActivityIndicator {
//    var activityIndicatorAppeared = false
//    var emptyArray: [Game] = []
//    
//    var searchController: UISearchController!
//    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
//
//    
//    func startAnimatingActivityIndicator(tableView: UITableView?, view: UIView, callback:@escaping ([Game]) -> () ) {
//        tableView?.reloadData()
//        activityIndicator.center = view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
//        callback(emptyArray)
//    }
//    
//    func stopAnimatingActivityIndicator() {
//    activityIndicator.stopAnimating()
//    
//    }
//}


func showActivityIndicatory(uiView: UIView) {
    let container: UIView = UIView()
    container.frame = uiView.frame
    container.center = uiView.center
    container.backgroundColor = UIColor.white
    
    let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = uiView.center
    loadingView.backgroundColor = UIColor.gray
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    uiView.addSubview(container)
    actInd.startAnimating()
}
