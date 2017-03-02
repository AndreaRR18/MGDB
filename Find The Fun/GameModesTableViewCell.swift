import UIKit

class GameModesTableViewCell: UITableViewCell {

    @IBOutlet weak private var gameModes: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureGameModesTableViewCell(_ nameGameModes: String) {
        self.backgroundColor = ColorUI.background
        gameModes?.textColor = ColorUI.text
        gameModes?.text = nameGameModes
    }

}
