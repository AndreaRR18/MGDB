import UIKit

final class GameModesTableViewCell: UITableViewCell, XIBConstructible {
    
    @IBOutlet weak private var gameModes: UILabel?
    
    static var cellIdentifier: String {
        return "GameModesTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(
            selected,
            animated: animated)
    }
    
    
    func configureGameModesTableViewCell(_ nameGameModes: String) {
        self.backgroundColor = ColorUI.background
        gameModes?.textColor = ColorUI.text
        gameModes?.text = nameGameModes
    }
}
