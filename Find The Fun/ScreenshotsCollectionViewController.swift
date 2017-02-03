import UIKit

private let reuseIdentifier = "Cell"

class ScreenshotsCollectionViewController: UICollectionViewController {
    
    var recipeImages = ["angry_birds_cake", "creme_brelee", "egg_benedict", "full_breakfast", "green_tea", "ham_and_cheese_panini", "ham_and_egg_sandwich", "hamburger", "instant_noodle_with_egg.jpg", "japanese_noodle_with_pork", "mushroom_risotto", "noodle_with_bbq_pork", "starbucks_coffee", "thai_shrimp_cake", "vegetable_curry", "white_chocolate_donut"]
    
    override func viewWillAppear(_ animated: Bool) {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:1,left:10,bottom:10,right:10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        
        self.collectionView?.collectionViewLayout = layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        collectionView?.register(ScreenshotCollectionViewCell(), forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.register(UINib(nibName: "GameCellTableViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScreenshotCollectionViewCell
        
        cell.screenshotImage?.image = UIImage(named: recipeImages[indexPath.row])
    
        return cell
    }

 
    
}
