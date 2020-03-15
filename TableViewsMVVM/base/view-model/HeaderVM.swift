import Foundation
import UIKit

public protocol HeaderVM {

}

public protocol IdentifiableHeaderVM {
    var headerType: UITableViewHeaderFooterView.Type { get }
}

extension IdentifiableHeaderVM {
    public var headerType: UITableViewHeaderFooterView.Type {
        return UITableViewHeaderFooterView.self
    }
}
