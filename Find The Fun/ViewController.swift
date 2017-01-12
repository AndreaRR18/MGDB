//
//  ViewController.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 12/01/17.
//  Copyright © 2017 Andrea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    init() {
        super.init(nibName: "Homepage", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Something")
        print("E' solo una prova")
        print("aahahah")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

