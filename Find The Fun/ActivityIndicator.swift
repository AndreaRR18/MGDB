//import Foundation
//import UIKit
//
//
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
