//import UIKit
//import SafariServices
//
//private let reuseIdentifier = "VideoCollectionViewCell"
//
//class VideoCollectionViewController: UICollectionViewController {
//    
//    let videos: [Video]
//    
//    init(videos: [Video]) {
//        self.videos = videos
//        super.init(nibName: "VideoCollectionViewController", bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        self.collectionView?.register(UINib(nibName: NibName.videoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifier.videoCollectionViewCell)
//        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        
//        layout.itemSize = CGSize(width: 145, height: 160)
//        layout.sectionInset = UIEdgeInsetsMake(5, 20, 15, 20)
//        layout.minimumInteritemSpacing = 10
//        self.collectionView?.setCollectionViewLayout(layout, animated: true)
//        collectionView?.delegate = self
//        collectionView?.dataSource = self
//        collectionView?.backgroundColor = UIColor.white
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return videos.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.videoCollectionViewCell, for: indexPath) as! VideoCollectionViewCell
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.borderWidth = 0.5
//        cell.url = getImagePreviewVideo(videoid: videos[indexPath.row].video_id)
//        cell.videoTitle?.text = videos[indexPath.row].name
//        return cell
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let idVideo = videos[indexPath.row].video_id, let url = getVideo(videoid: idVideo) else { return }
//        let safariVC = SFSafariViewController(url: url)
//        self.present(safariVC, animated: true, completion: nil)
//    }
//}
