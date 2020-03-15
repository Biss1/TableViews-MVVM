import Foundation

//MARK: - Reusable UI element Protocol
public protocol ReusableUIElementProtocol: class {
    ///Matching the name of the class. Used both for dequeuing views and registering nibs.
    static var reuseIdentifier: String {get}
}

extension ReusableUIElementProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
