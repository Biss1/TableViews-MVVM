import UIKit

struct FormCellVM: CellVM {
    var title: String?
    var placeholder: String
    var text: String
    var error: String?
    
    var type: PlaceDetailsCellType = .none
}

extension FormCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        FormCell.self
    }
}
