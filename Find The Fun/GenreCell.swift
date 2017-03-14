import Foundation
import UIKit

class GenreCell: CellFactory {
    private let genre: [Int]
    
    init(_ genre: [Int]) {
        self.genre = genre
    }
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
        GenreCoreData.nameGenreDB(id: genre, callback: { nameGenre in
            cell.configureGenreTableViewCell(nameGenre)
        })
        return cell
    }
}
