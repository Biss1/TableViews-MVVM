class PlacesOverviewVM: BaseTableVM {
    var headerTitle: String = "Places"
    var delegate: BaseTableVMDelegate?
    
    var tableViewModel: BaseTableSource {
        var sections: [TableSectionVM] = []
        switch groupingType {
        case .byPlaceType:
            sections = placesGroupedByType()
        case .byCountry:
            sections = placesGroupedByCountry()
        }
        
        return BaseTableSource(data: sections)
    }
    
    var groupingType: PlacesGroupingType = .byPlaceType
    
    init(delegate: BaseTableVMDelegate) {
        self.delegate = delegate
    }
    
    func switchGroupingType() {
        groupingType = groupingType == .byPlaceType ? .byCountry: .byPlaceType
        delegate?.updateView()
    }
    
    func placesGroupedByType() -> [TableSectionVM] {
        let visitedPlacesIds = DataService.visitedPlacesIds
        let placesGrouped = Dictionary(grouping: DataService.places, by: { $0.category })
        let places = placesGrouped.mapValues { (places) -> [PlaceImageCellVM] in
            places.map { (place) -> PlaceImageCellVM in
                let visited = visitedPlacesIds.contains(place.id)
                return PlaceImageCellVM(name: place.name,
                                        imageName: place.image,
                                        showVisitedIcon: visited)
            }
        }
        return places.map({ (arg) -> TableSectionVM in
            let (placeType, placeCellVMs) = arg
            let headerVM = BaseHeaderVM(title: placeType.description())
            return TableSectionVM(cellData: placeCellVMs, headerVM: headerVM)
        })
    }
    
    func placesGroupedByCountry() -> [TableSectionVM] {
        let placesGrouped = Dictionary(grouping: DataService.places, by: { $0.country })
        let places = placesGrouped.mapValues { (places) -> [PlaceCellVM] in
            places.map { (place) -> PlaceCellVM in
                let ratings = DataService.ratings.filter({ $0.placeId == place.id })
                                                 .map( {$0.stars })
                return PlaceCellVM(name: place.name, imageName: place.image,
                                   placeIconName: "icon_" + place.category.rawValue,
                                   stars: Int(ratings.average),
                                   ratings: ratings.count)
            }
        }
        return places.map({ (arg) -> TableSectionVM in
            let (placeCountry, placeCellVMs) = arg
            let headerVM = BaseHeaderVM(title: placeCountry)
            return TableSectionVM(cellData: placeCellVMs, headerVM: headerVM)
        })
    }
    
    enum PlacesGroupingType {
        case byPlaceType
        case byCountry
    }
}

