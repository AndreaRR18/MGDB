import UIKit

final class GenreTableViewCell: UITableViewCell, XIBConstructible {
    
    @IBOutlet weak private var genres: UILabel?
    
    static var cellIdentifier: String {
        return "GenreTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(
            selected,
            animated: animated)
    }
    
    
    func configureGenreTableViewCell(_ nameGenre: String) {
        self.backgroundColor = ColorUI.background
        self.genres?.textColor = ColorUI.text
        genres?.text = nameGenre
    }
}

