import Foundation

let visitedPlaceIds = "VisitedPlacesIds"

enum PlaceCategory: String, CaseIterable {
    case none = "none"
    case lake = "lake"
    case mountain = "mountain"
    case river = "river"
    
    func description() -> String {
        switch self {
        case .lake:
            return "Lakes"
        case .mountain:
            return "Mountains"
        case .river:
            return "Rivers"
        case .none:
            return "None"
        }
    }
}

struct Rating {
    var id: Int
    var comment: String
    var stars: Int
    var placeId: Int
}

struct DataService {
    
    static var places: [Place] {
        // lakes
        [Lake(id: 1, name: "Ohrid lake", image: "ohrid_lake", category: .lake, country: "Macedonia",
              coordinates: Coordinates(latitude: 41.0419, longitude: 20.7190),
              lakeType: "Ancient, tectonic lake", primaryInflows: "Sateska River, Biljana's springs, underground link with Lake Prespa",
              primaryOutflows: "Black Drin River", maxLength: 36.4, maxWidth: 16.8, surfaceArea: 388,
              maxDepth: 300, residenceTime: 70),
         Lake(id: 2, name: "Crater Lake", image: "crater_lake", category: .lake, country: "US"),
         Lake(id: 3, name: "Dead Sea", image: "dead_sea", category: .lake, country: "Jordan"),
         Lake(id: 4, name: "Laguna Colorada", image: "laguna_colorada", category: .lake, country: "Bolivia"),
         Lake(id: 5, name: "Lake Wakatipu", image: "lake_wakatipu", category: .lake, country: "New Zealand"),
         Lake(id: 6, name: "Plitvice Lakes", image: "plitvice_lakes", category: .lake, country: "Croatia"),
         
         // rivers
            River(id: 7, name: "Amazon", image: "amazon_river", category: .river, country: "Brazil",
                  source: "Huancayo, Huancayo Province, Peru", mouth: "Atlantic Ocean, Brazil",
                  length: 6575, basinSize: 7050000, maxWidth: 100, maxDepth: 100, averageDischarge: 209000000),
         River(id: 8, name: "Nile", image: "nile_river", category: .river, country: "Egypt"),
         River(id: 9, name: "Cano Cristales", image: "cano_cristales", category: .river, country: "Colombia"),
         
         // mountains
         Mountain(id: 10, name: "Alps", image: "alps", category: .mountain, country: "France",
                  coordinates: Coordinates(latitude: 46.8876, longitude: 9.6570),
                  highestPeak: "Mount Blanc", elevation: 4808.73, orogeny: "alpine orogeny",
                  length: 1200, width: 250, area: 200000),
         Mountain(id: 11, name: "Mount Fuji", image: "mount-fuji", category: .mountain, country: "Japan"),
         Mountain(id: 12, name: "Huayna Picchu", image: "hauyna-picchu", category: .mountain, country: "Peru"),
         Mountain(id: 13, name: "Kirkjufell", image: "Kirkjufell", category: .mountain, country: "Iceland"),
        ]
    }
    
    static func getPlaceById(_ placeId: Int) -> Place? {
        self.places.filter({ placeId == $0.id }).first
    }
    
    static var ratings: [Rating] {
        [Rating(id: 1, comment: "", stars: 5, placeId: 1),
         Rating(id: 1, comment: "", stars: 5, placeId: 1),
         Rating(id: 1, comment: "", stars: 3, placeId: 2),
         Rating(id: 1, comment: "", stars: 5, placeId: 2),
         Rating(id: 1, comment: "", stars: 5, placeId: 3)]
    }

    static var visitedPlacesIds: [Int] {
        let defaults = UserDefaults.standard
        return  defaults.array(forKey: visitedPlaceIds)  as? [Int] ?? [Int]()
    }
    
    static func addPlaceToVisited(id: Int) {
        var placeIds = self.visitedPlacesIds
        placeIds.append(id)

        let defaults = UserDefaults.standard
        defaults.set(placeIds, forKey: visitedPlaceIds)
    }
}
