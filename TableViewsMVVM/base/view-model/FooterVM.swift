import Foundation
import UIKit

public protocol FooterVM {
    
}

public protocol IdentifiableFooterVM {
    var footerType: UITableViewHeaderFooterView.Type { get }
}

extension IdentifiableFooterVM {
    public var footerType: UITableViewHeaderFooterView.Type {
        return UITableViewHeaderFooterView.self
    }
    
}
