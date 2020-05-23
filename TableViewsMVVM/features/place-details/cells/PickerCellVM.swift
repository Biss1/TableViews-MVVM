import UIKit

class PickerCellVM: CellVM {
    
}

extension PickerCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        PickerCell.self
    }
}
