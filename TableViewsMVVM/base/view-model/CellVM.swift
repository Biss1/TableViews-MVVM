import Foundation
import UIKit

public protocol CellVM {}

public protocol IdentifiableCellVM {
    var cellType: UITableViewCell.Type { get }
}
