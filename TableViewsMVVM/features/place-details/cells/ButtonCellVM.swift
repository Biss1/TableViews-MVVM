import UIKit

struct ButtonCellVM: CellVM {
    
}

extension ButtonCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        ButtonCell.self
    }
}
