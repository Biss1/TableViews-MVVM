protocol Place {
    var id: Int { get set }
    var name: String { get set }
    var description: String? { get set }
    var image: String { get set }
    var category: PlaceCategory { get set }
    var country: String { get set }
}

struct Coordinates {
    var latitude: Double
    var longitude: Double
}

struct Mountain: Place {
    var id: Int
    var name: String
    var description: String?
    var image: String
    var category: PlaceCategory
    var country: String
    var coordinates: Coordinates? // 45°49′58″N 06°51′54″E
    
    var highestPeak: String? //Mont Blanc
    var elevation: Float? //4,808.73 m (15,776.7 ft) [1]
    var orogeny: String? // alpine orogeny
    var length: Float? // 1,200 km (750 mi)
    var width: Float? // 250 km (160 mi)
    var area: Float?  //Area    200,000 km2 (77,000 sq mi)
}

struct River: Place {
    var id: Int
    var name: String
    var description: String?
    var image: String
    var category: PlaceCategory
    var country: String
    
    var source: String? // ⁃ location    Huancayo, Huancayo Province, Peru
    var mouth: String? //Atlantic Ocean  location    Brazil
    var length: Float?  // 6,575 km (4,086 mi)[n 1]
    var basinSize: Float? // 7,050,000 square kilometres (2,722,020 sq mi)[2]
    var maxWidth: Float? // maximum    100 km (62 mi)
    var maxDepth: Float? //  // ⁃ maximum    100 m (330 ft)
    var averageDischarge: Float? // average    209,000 cubic metres per second (7,400,000 cu ft/s; 209,000,000 L/s; 55,000,000 USgal/s)[5]
}

struct Lake: Place {
    var id: Int
    var name: String
    var description: String?
    var image: String
    var category: PlaceCategory
    var country: String
    var coordinates: Coordinates? //41°02′14″N 20°43′08″ECoordinates: 41°02′14″N 20°43′08″E
    
    var lakeType: String? // ancient, tectonic lake
    var primaryInflows: String? // Sateska River, Biljana's springs, underground link with Lake Prespa
    var primaryOutflows: String? // Black Drin River
    var maxLength: Float? // 36.4 km (22.6 mi)
    var maxWidth: Float? // 16.8 km (10.4 mi)
    var surfaceArea: Float? // 388 km2 (150 sq mi)
    var maxDepth: Float? //  ~300 m (980 ft)
    var residenceTime: Int? // 70 years
}
