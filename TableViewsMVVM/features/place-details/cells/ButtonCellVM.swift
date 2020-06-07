import UIKit

struct ButtonCellVM: CellVM {
    var isEnabled: Bool = true
}

extension ButtonCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        ButtonCell.self
    }
}
