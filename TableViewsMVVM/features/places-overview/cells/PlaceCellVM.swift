import  UIKit

struct PlaceCellVM: CellVM {
    var id: Int
    var name: String
    var imageName: String = ""
    var placeIconName: String = ""
    var stars: Int
    var ratings: Int
    
    init(place: Place, placeRatings: [Int]) {
        id = place.id
        name = place.name
        imageName = place.image
        placeIconName = "icon_" + place.category.rawValue
        stars = Int(placeRatings.average)
        ratings = placeRatings.count
    }
}

extension PlaceCellVM: IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        PlaceCell.self
    }
}
