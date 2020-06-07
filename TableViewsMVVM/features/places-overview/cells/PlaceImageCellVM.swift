import UIKit

struct PlaceImageCellVM: CellVM {
    var id: Int
    var name: String
    var imageName: String
    var showVisitedIcon: Bool
    
    init(place: Place, visited: Bool) {
        id = place.id
        name = place.name
        imageName = place.image
        showVisitedIcon = visited
    }
}

extension PlaceImageCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        PlaceImageCell.self
    }
}
