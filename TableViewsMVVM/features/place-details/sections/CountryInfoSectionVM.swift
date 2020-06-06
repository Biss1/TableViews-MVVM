class CountryInfoSectionVM: SectionVM {
    var country: String = ""
    var showCoordinates: Bool = false
    
    var countryCellVM: CellVM {
        PickerCellVM(title: "Country: ", value: country)
    }
    
    var coordinatesCellVM: CellVM {
        SwitchCellVM(title: "Enter coordinates", switchValue: true, type: .coordinatesSwitch)
    }
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? = BaseHeaderVM(title: "Location information")
    
    var cellsVMs: [CellVM] {
        return [countryCellVM, coordinatesCellVM].compactMap{ $0 }
    }
}
