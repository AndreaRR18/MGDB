import UIKit

class ScreenshotCollectionTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var screenshotCollectionView: UICollectionView?
    
    static var screenshotCollectionTableViewCellIdentifier: String { return "ScreenshotCollectionTableViewCell" }
    
    var arrayScreenshot: [Screenshots] = [] {
        didSet {
            screenshotCollectionView?.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        screenshotCollectionView?.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: ScreenshotCollectionViewCell.screenshotImageReuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayScreenshot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.screenshotImageReuseIdentifier, for: indexPath) as! ScreenshotCollectionViewCell
        guard let urlString = arrayScreenshot[indexPath.row].url, let url = URL(string: urlString) else { return cell }
        cell.url = url
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 4
        let hardCodePadding: CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodePadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodePadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }

    
}
