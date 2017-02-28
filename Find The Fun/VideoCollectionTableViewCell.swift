import UIKit
import SafariServices

protocol VideoDelegate: class {
    func openSafariView(_ url: URL)
}

class VideoCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewVideo: UICollectionView?
    weak var delegate: VideoDelegate?

    var video: [Video] = [] {
        didSet {
            self.collectionViewVideo?.register(UINib(nibName: NibName.videoDescriptionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.videoDescriptionCollectionViewCell)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 145, height: 160)
            layout.sectionInset = UIEdgeInsetsMake(5, 20, 15, 20)
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
            collectionViewVideo?.setCollectionViewLayout(layout, animated: true)
            collectionViewVideo?.delegate = self
            collectionViewVideo?.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension VideoCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (video.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.videoDescriptionCollectionViewCell, for: indexPath) as! VideoDescriptionCollectionViewCell
        cell.url = getImagePreviewVideo(videoid: video[indexPath.row].video_id)
        cell.titleVideo?.text = video[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let idVideo = video[indexPath.row].video_id, let url = getVideo(videoid: idVideo) else { return }
        print(url)
        self.delegate?.openSafariView(url)
    }
}
