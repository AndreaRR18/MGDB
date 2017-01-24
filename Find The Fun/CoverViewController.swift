import UIKit


class CoverViewController: UIViewController {

    @IBOutlet weak var coverHighResolution: UIImageView?
    
    let placeholder = #imageLiteral(resourceName: "img-not-found")
    var coverURL: String?
    
    required init(coverURL: String?) {
        super.init(nibName: "CoverViewController", bundle: nil)
        self.coverURL = coverURL
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlExist = getCover(url: coverURL) {
            coverHighResolution?.af_setImage(
                withURL: urlExist,
                placeholderImage: placeholder,
                imageTransition: .crossDissolve(0.3),
                runImageTransitionIfCached: true)
        } else {
            coverHighResolution?.image = placeholder
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    let placeholder = #imageLiteral(resourceName: "img-not-found")
//    if let urlExist = getUrlHttps(url: cover?.url) {
//        cell.thumbnail?.af_setImage(
//            withURL: urlExist,
//            placeholderImage: placeholder,
//            imageTransition: .crossDissolve(0.5),
//            runImageTransitionIfCached: true)
//        
//    } else {
//    cell.thumbnail?.image = placeholder
//    }


}
