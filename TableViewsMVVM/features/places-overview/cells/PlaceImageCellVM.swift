import UIKit

struct PlaceImageCellVM: CellVM {
    var name: String
    var imageName: String
    var showVisitedIcon: Bool
}

extension PlaceImageCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        PlaceImageCell.self
    }
}
