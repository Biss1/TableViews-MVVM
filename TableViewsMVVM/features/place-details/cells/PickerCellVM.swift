import UIKit

struct PickerCellVM: CellVM {
    var title: String
    var value: String
    var type: PlaceDetailsCellType = .categoryPicker
    var error: String?
}

extension PickerCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        PickerCell.self
    }
}
