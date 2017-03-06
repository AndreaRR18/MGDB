import Foundation

extension String: Error {}

struct TypeCast {
    static func get<T>(_ value: Any?, as type: T.Type) throws -> T {
        guard let cast = value as? T else {
            throw "TypeCast - should be '\(type)', but is \(value)"
        }
        return cast
    }
}
