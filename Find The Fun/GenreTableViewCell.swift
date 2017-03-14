import UIKit

class GenreTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var genres: UILabel?
    
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

