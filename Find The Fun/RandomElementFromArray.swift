import Foundation


extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

postfix operator <->
postfix func <-> <T> (array: [T]) -> [T] {
    var arrayShuffle: [T] = []
    array.forEach { value in
            arrayShuffle.append(array.randomItem())
    }
    return arrayShuffle
}
