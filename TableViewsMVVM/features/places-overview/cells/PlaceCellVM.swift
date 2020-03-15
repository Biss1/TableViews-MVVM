import  UIKit

struct PlaceCellVM: CellVM {
    var name: String
    var imageName: String = ""
    var placeIconName: String = ""
    var stars: Int
    var ratings: Int
}

extension PlaceCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        PlaceCell.self
    }
}
