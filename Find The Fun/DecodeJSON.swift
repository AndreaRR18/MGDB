//import Foundation
//import UIKit
//import Argo
//
//
//class DecodeJSON {
//    
//    func getGame(gameURL: String, tableView: UITableView) -> Game? {
//        guard let url = URL(string: gameURL) else { return }
//        let request = URLRequest(url: url)
//        let game: Game?
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {
//            (data, response, error) -> Void in
//            let json: Any? = try? JSONSerialization.jsonObject(with: data!, options: [])
//            if let error = error {
//                print(error)
//                return
//            }
//
//            if let j: Any = json {
//                self.getGame = decode(j)
//                OperationQueue.main.addOperation {
//                    tableView.reloadData()
//                }
//            } else {
//                self.game = nil
//            }
//            
//        })
//        task.resume()
//        return game
//    }
//    
//}
