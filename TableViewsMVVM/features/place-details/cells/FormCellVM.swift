import UIKit

class FormCellVM: CellVM {
    
}

extension FormCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        FormCell.self
    }
}
