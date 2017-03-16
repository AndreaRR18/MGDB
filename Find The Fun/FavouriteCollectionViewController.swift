import UIKit

private let reuseIdentifier = "FavouriteCollectionViewCell"

class FavouriteCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DeleteDelegate {
    
    private  var favouriteGame: [FavouriteGameData]? = []
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 40, right: 10)
    private let itemsPerRow: CGFloat = 2
    private var favouriteGameChange: [FavouriteGameData] = []
    
    init() {
        super.init(nibName: "FavouriteCollectionViewController", bundle: nil)
        
        self.favouriteGame = self.getGame()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ChangeFavouriteGame"), object: nil, queue: nil) { _ in
            self.favouriteGame = self.getGame()
            self.collectionView?.reloadData()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(
            UINib(nibName: NibName.favouriteCollectionCell, bundle: nil),
            forCellWithReuseIdentifier: Identifier.favouriteCollectionCell)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection  = .vertical
        
        collectionView?.setCollectionViewLayout(
            layout,
            animated: true)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ChangeFavouriteGame"), object: nil, queue: nil) { _ in
            self.favouriteGame = self.getGame()
            self.collectionView?.reloadData()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(self.showButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(
                false,
                animated: animated)
        }
        
        navigationItem.title = "Favourite"
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor = ColorUI.navBar
        
        collectionView?.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let favouriteGame = favouriteGame else { return 0 }
        return favouriteGame.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.favouriteCollectionCell, for: indexPath) as! FavouriteCollectionViewCell
        
        cell.delegate = self
        cell.configureFavouriteGameCell(favouriteGame?[indexPath.row])
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navController = navigationController, let favouriteGame = favouriteGame?[indexPath.row] else { return }
        
        navController.pushViewController(
            FavouriteDescriptionViewController(game: favouriteGame),
            animated: true)
    }
    
    
    func getGame() -> [FavouriteGameData]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            return try context.fetch(FavouriteGameData.fetchRequest())
        } catch {
            print("Fetching Failed")
            return nil
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    func delete(idGame: Int32) {
        deleteFavouriteGame(id: idGame)
        
        NotificationCenter.default.post(
            name: NSNotification.Name("ChangeFavouriteGame"),
            object: nil)
    }
    
    
    func showButton() {
        NotificationCenter.default.post(
            name: NSNotification.Name("ShowHideButton"),
            object: nil)
    }
}
