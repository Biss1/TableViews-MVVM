import UIKit

class SwitchCellVM: CellVM {
    
}

extension SwitchCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        SwitchCell.self
    }
}
