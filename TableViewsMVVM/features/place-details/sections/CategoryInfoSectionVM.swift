class CategoryInfoSectionVM: SectionVM {
    var category: PlaceCategory = .river
    
    var length: Int? // lake max length
    var width: Int? // lake max width
    var area: Int?
    var elevation: Int? // mountain, lake - surface elevation
    var peak: String? // mountain
    var primaryInflows: String?
    var primaryOutflows: String?
    var ageOfRock: String? // mountain
    var residenceTime: Int? // lake
    var averageDischarge: Int? // river
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? {
        var title = ""
        switch category {
        case .river:
             title = "River info"
        case .lake:
            title = "Lake info"
        case .mountain:
            title = "Mountain info"
        }
        return BaseHeaderVM(title: title)
    }
    
    var lengthCellVM: CellVM {
        let placeholder = category == .lake ? "Max length" : "Length"
        return FormCellVM(placeholder: placeholder, text: "")
    }
    
    var widthCellVM: CellVM {
        let placeholder = category == .lake ? "Max width" : "Width"
        return FormCellVM(placeholder: placeholder, text: "")
    }
    
    var areaCellVM: CellVM {
        FormCellVM(placeholder: "Area", text: "")
    }
    
    var elevationCellVM: CellVM {
        FormCellVM(placeholder: "Elevation", text: "")
    }
    
    var peakCellVM: CellVM? {
        if category == .mountain {
            return FormCellVM(placeholder: "Peak", text: "")
        }
        return nil;
    }
    
    var cellsVMs: [CellVM] {
        [peakCellVM, lengthCellVM, widthCellVM, areaCellVM, elevationCellVM].compactMap{ $0 }
    }
}
