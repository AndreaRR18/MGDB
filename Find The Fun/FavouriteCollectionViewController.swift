import UIKit

private let reuseIdentifier = "FavouriteCollectionViewCell"

class FavouriteCollectionViewController: UICollectionViewController {
    
    var favouriteGame: [FavouriteGameData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(UINib(nibName: NibName.favouriteCollectionCell, bundle: nil), forCellWithReuseIdentifier: Identifier.favouriteCollectionCell)
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


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteGame.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.favouriteCollectionCell, for: indexPath) as! FavouriteCollectionViewCell
    
        return cell
    }

}
