class PlacesOverviewVM: BaseTableVM {
    var headerTitle: String = "Places"
    var delegate: BaseTableVMDelegate?
    
    var tableViewModel: BaseTableSource {
        var sections: [TableSectionVM] = []
        switch groupingType {
        case .byCategory:
            sections = placesGroupedByCategory()
        case .byCountry:
            sections = placesGroupedByCountry()
        }
        
        return BaseTableSource(tableData: sections)
    }
    
    var groupingType: PlacesGroupingType = .byCategory
    
    init(delegate: BaseTableVMDelegate) {
        self.delegate = delegate
    }
    
    func switchGroupingType() {
        groupingType = groupingType == .byCategory ? .byCountry: .byCategory
        delegate?.updateView()
    }
    
    func placesGroupedByCategory() -> [TableSectionVM] {
        let visitedPlacesIds = DataService.visitedPlacesIds
        let placesGrouped = Dictionary(grouping: DataService.places, by: { $0.category })
        let places = placesGrouped.mapValues { (places) -> [PlaceImageCellVM] in
            places.map { (place) -> PlaceImageCellVM in
                let visited = visitedPlacesIds.contains(place.id)
                return PlaceImageCellVM(place: place, visited: visited)
            }
        }
        let sections =  places.map({ (arg) -> TableSectionVM in
            let (placeType, placeCellVMs) = arg
            let headerVM = BaseHeaderVM(title: placeType.description())
            return TableSectionVM(headerVM: headerVM, cellData: placeCellVMs)
        })
        return sections.sorted(by: sortSection)
    }
    
    func placesGroupedByCountry() -> [TableSectionVM] {
        let placesGrouped = Dictionary(grouping: DataService.places, by: { $0.country })
        let places = placesGrouped.mapValues { (places) -> [PlaceCellVM] in
            places.map { (place) -> PlaceCellVM in
                let ratings = DataService.ratings.filter({ $0.placeId == place.id })
                                                 .map( {$0.stars })
                return PlaceCellVM(place: place, placeRatings: ratings)
            }
        }
        let sections = places.map({ (arg) -> TableSectionVM in
            let (placeCountry, placeCellVMs) = arg
            let headerVM = BaseHeaderVM(title: placeCountry)
            return TableSectionVM(headerVM: headerVM, cellData: placeCellVMs)
        })
        return sections.sorted(by: sortSection)
    }
    
    func sortSection(first: TableSectionVM, second: TableSectionVM) -> Bool {
        return (first.headerVM as! BaseHeaderVM).title < (second.headerVM as! BaseHeaderVM).title
    }
    
    enum PlacesGroupingType {
        case byCategory
        case byCountry
    }
}

