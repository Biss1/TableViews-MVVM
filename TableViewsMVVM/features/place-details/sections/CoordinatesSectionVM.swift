class CoordinatesSectionVM: SectionVM {
    var latitude: String = ""
    var longitude: String = ""
    
    var latitudeCellVM: CellVM {
        FormCellVM(placeholder: "Latitude", text: "")
    }
    
    var longitudeCellVM: CellVM {
        FormCellVM(placeholder: "Longitude", text: "")
    }
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? = BaseHeaderVM(title: "Coordinates")
    
    var cellsVMs: [CellVM] {
        return [latitudeCellVM, longitudeCellVM].compactMap{ $0 }
    }
}
