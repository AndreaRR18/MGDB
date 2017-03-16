import UIKit

final class ReleaseDatePlatformTableViewCell: UITableViewCell, XIBConstructible {
    
    @IBOutlet weak var platform: UILabel?
    @IBOutlet weak var date: UILabel?
    
    static var cellIdentifier: String {
        return "ReleaseDatePlatformTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(
            selected,
            animated: animated)
    }
    
    
    func configureReleaseDateTableViewCell(_ platform: String?, _ date: String?) {
        self.backgroundColor = ColorUI.background
        self.platform?.textColor = ColorUI.text
        self.platform?.text = "\(platform ?? ""): "
        self.date?.textColor = ColorUI.text
        self.date?.text = date
    }
}
