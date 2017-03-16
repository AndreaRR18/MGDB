import Foundation
import UIKit

class GenreCell: CellFactory {
    
    private let genre: [Int]
    
    init(_ genre: [Int]) {
        self.genre = genre
    }
    
    
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(
            at: indexPath,
            animated: true)
    }
    
    
    func getCell(tableView: UITableView, indexPath: IndexPath, handleError: @escaping (Error) -> ()) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.genreTableViewCell, for: indexPath) as! GenreTableViewCell
        
        GenreCoreData.nameGenreDB(
            id: genre,
            callback: { getGenre in
                do {
                    let nameGenre = try getGenre()
                    cell.configureGenreTableViewCell(nameGenre)
                } catch let error {
                    handleError(error)
                }
        })
        
        return cell
    }
}
