import UIKit

private let reuseIdentifier = "ScreenshotCollectionViewCell"

class ScreenshotsCollectionViewController: UICollectionViewController {
    
    var arrayScreenshots: [Screenshots]
    
    init(arrayScreenshots: [Screenshots]) {
        self.arrayScreenshots = arrayScreenshots
        super.init(nibName: "ScreenshotsCollectionViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(UINib(nibName: "ScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenshotCollectionViewCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 170, height: 170)
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
        layout.minimumInteritemSpacing = 10
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayScreenshots.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.screenshotCollectionViewCellIdentifier, for: indexPath) as! ScreenshotCollectionViewCell
        cell.url = getHDImage(url: arrayScreenshots[indexPath.row].url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(CoverViewController(coverURL: arrayScreenshots[indexPath.row].url), animated: true)
        navigationController?.present(CoverViewController(coverURL: arrayScreenshots[indexPath.row].url), animated: true, completion: {
            
        })
    }

}
