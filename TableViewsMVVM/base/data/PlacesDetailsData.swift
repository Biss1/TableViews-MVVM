//struct Mountain: Place {
//    
//}
//
//struct River: Place {
//    
//}
//
//struct Lake: Place {
//    
//}

extension DataService {
    static var placesWithDetails: [Place] {
        // lakes
        [Place(id: 1, name: "Ohrid lake", image: "ohrid_lake", category: .lake, country: "Macedonia"),
         Place(id: 2, name: "Crater Lake", image: "crater_lake", category: .lake, country: "US"),
         Place(id: 3, name: "Dead Sea", image: "dead_sea", category: .lake, country: "Jordan"),
         Place(id: 4, name: "Laguna Colorada", image: "laguna_colorada", category: .lake, country: "Bolivia"),
         Place(id: 5, name: "Lake Wakatipu", image: "lake_wakatipu", category: .lake, country: "New Zealand"),
         Place(id: 6, name: "Plitvice Lakes", image: "plitvice_lakes", category: .lake, country: "Croatia"),
        
         // rivers
         Place(id: 7, name: "Amazon", image: "amazon_river", category: .river, country: "Brazil"),
         Place(id: 6, name: "Nile", image: "nile_river", category: .river, country: "Egypt"),
         Place(id: 6, name: "Cano Cristales", image: "cano_cristales", category: .river, country: "Colombia"),
         
         // mountains
         Place(id: 6, name: "Mount Fuji", image: "mount-fuji", category: .mountain, country: "Japan"),
         Place(id: 6, name: "Huayna Picchu", image: "hauyna-picchu", category: .mountain, country: "Peru"),
         Place(id: 6, name: "Kirkjufell", image: "Kirkjufell", category: .mountain, country: "Iceland"),
        ]
    }
}
