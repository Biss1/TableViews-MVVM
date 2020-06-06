import UIKit

struct SwitchCellVM: CellVM {
    var title: String
    var switchValue: Bool
    var type: PlaceDetailsCellType
}

extension SwitchCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        SwitchCell.self
    }
}
