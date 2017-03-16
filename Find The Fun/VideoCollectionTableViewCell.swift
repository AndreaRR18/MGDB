import UIKit
import SafariServices

protocol VideoDelegate: class {
    func openSafariView(_ url: URL)
}


final class VideoCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, XIBConstructible {
    
    @IBOutlet weak private var collectionViewVideo: UICollectionView?
    
    static var cellIdentifier: String {
        return "VideoCollectionTableViewCell"
    }
    
    weak var delegate: VideoDelegate?
    private var video: [Video] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(
            selected,
            animated: animated)
    }
    
    
    func configureVideoCollectionTableViewCell (_ video: [Video]) {
        self.collectionViewVideo?.register(
            UINib(nibName: NibName.videoDescriptionCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Identifier.videoDescriptionCollectionViewCell)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 145, height: 140)
        layout.sectionInset = UIEdgeInsetsMake(5, 20, 15, 20)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        collectionViewVideo?.setCollectionViewLayout(
            layout,
            animated: true)
        
        collectionViewVideo?.delegate = self
        collectionViewVideo?.dataSource = self
        
        self.video = video
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (video.count)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.videoDescriptionCollectionViewCell, for: indexPath) as! VideoDescriptionCollectionViewCell
        
        cell.url = GetUrl.getImagePreviewVideo(videoid: video[indexPath.row].video_id)
        cell.titleVideo?.text = video[indexPath.row].name
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let idVideo = video[indexPath.row].video_id, let url = GetUrl.getVideo(videoid: idVideo) else { return }
        self.delegate?.openSafariView(url)
    }
}
