//
//  AnimationHideShowTabBarController.swift
//  Find The Fun
//
//  Created by Andrea & Beatrice on 02/03/17.
//  Copyright © 2017 Andrea. All rights reserved.
//

import Foundation
import UIKit

enum Action {
    case hide
    case show
}

class AnimationHideShowTabBarController {
    
    static func setTabBarVisible(view: UIView, tabBarController: UITabBarController, action: Action, animated:Bool) {
        
        if action == Action.hide {
            
            let frame = tabBarController.tabBar.frame
            let height = frame.size.height
            let offsetY = height
            
            let duration:TimeInterval = (animated ? 0.3 : 0.0)
            
            UIView.animate(withDuration: duration) {
                tabBarController.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
                return
            }
            
        } else {
            let frame = tabBarController.tabBar.frame
            let height = frame.size.height
            let offsetY = -height
            
            let duration:TimeInterval = (animated ? 0.3 : 0.0)
            
            UIView.animate(withDuration: duration) {
                tabBarController.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
                return
            }
        }
    }
}
