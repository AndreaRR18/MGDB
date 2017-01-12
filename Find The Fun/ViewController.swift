//
//  ViewController.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 12/01/17.
//  Copyright © 2017 Andrea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let igdbURL = "https://igdbcom-internet-game-database-v1.p.mashape.com/genres/12?fields=*"
    var games = [Game]()
    
    init() {
        super.init(nibName: "Homepage", bundle: nil)
    }
    @IBAction func Search(_ sender: Any) {
        let openLink = URL(string : "https://www.igdb.com")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(openLink!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(openLink!)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLastestGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getLastestGame() {
        guard let igdb = URL(string: igdbURL) else { return }
        let request = URLRequest(url: igdb)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.games = self.parseJsonData(data: data)
                
                OperationQueue.main.addOperation {
                    self.navigationController?.pushViewController(GameTableViewController(), animated: true)
                }
            }
        })
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Game] {
        var games = [Game]()
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            let json
        }
    }

}

