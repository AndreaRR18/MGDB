//import UIKit
//import Argo
//
//class SearchGame {
//    var apiKey: String
//    var httpHeaderField: String
//    var searchController: UISearchController!
//    
//    init(apiKey: String, httpHeaderField: String) {
//        self.apiKey = apiKey
//        self.httpHeaderField = httpHeaderField
//    }
//    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        guard let searchText = searchBar.text else { return }
//        
//        guard searchText.characters.count > 3 else { return }
//        let decodedJSON = DecodeGameJSON(gamesURL: getUrlSearchedGames(title: searchText), apiKey: apiKey, httpHeaderField: httpHeaderField)
//        let urlGame = getUrlSearchedGames(title: searchText)
//        print(urlGame)
//        decodedJSON.getGames(callback: { arrayGames in
//            print(arrayGames)
//            self.arrayGames = arrayGames
//            self.tableView.reloadData()
//            
//        })
//    }
//}


