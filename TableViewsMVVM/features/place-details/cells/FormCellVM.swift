import UIKit

struct FormCellVM: CellVM {
    var placeholder: String
    var text: String
}

extension FormCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        FormCell.self
    }
}
