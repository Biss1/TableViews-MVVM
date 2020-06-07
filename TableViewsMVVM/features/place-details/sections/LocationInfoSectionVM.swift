class LocationInfoSectionVM: SectionVM {
    var category: PlaceCategory = .none
    var country: String = ""
    var showCoordinates: Bool = false
    
    // MARK: - Cells VM
    var countryCellVM: CellVM {
        PickerCellVM(title: "Country: ", value: country)
    }
    
    var coordinatesCellVM: CellVM? {
        if category != .river {
            return SwitchCellVM(title: "Enter coordinates",
                                switchValue: showCoordinates,
                                type: .coordinatesSwitch)
        }
        return nil
    }
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? = BaseHeaderVM(title: "Location information")
    
    var cellsVMs: [CellVM] {
        return [countryCellVM, coordinatesCellVM].compactMap{ $0 }
    }
    
    //MARK:- Update
    func update(with place: Place) {
        category = place.category
        country = place.country
        if let lake = place as? Lake, lake.coordinates != nil {
            showCoordinates = true
        }
        if let mountain = place as? Mountain, mountain.coordinates != nil {
            showCoordinates = true
        }
    }
}
