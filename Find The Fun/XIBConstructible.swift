import Foundation
import UIKit

protocol XIBConstructible {
    static var fromXIB: Self { get }
}

extension XIBConstructible {
    static var fromXIB: Self {
        return UINib(nibName: "\(Self.self)", bundle: nil)
            .instantiate(withOwner: nil, options: nil)
            .first as! Self
    }
}
