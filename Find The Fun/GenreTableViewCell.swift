import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var genres: UILabel?
    
    static var genresTableViewCellIdentifier: String { return "GenreTableViewCell" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
