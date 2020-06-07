import Foundation

class CoordinatesSectionVM: SectionVM {
    var latitude: Double?
    var longitude: Double?
    
    var validLatitude: Bool { latitude ?? 0 >= -90.0 && latitude ?? 0 <= 90.0  }
    var validLongitude: Bool { longitude ?? 0 >= -180.0 && longitude ?? 0 <= 180.0  }
    
    // MARK: - Cells VM
    var latitudeCellVM: CellVM {
        let text = latitude != nil ? String(format: "%f", latitude!) : ""
        var cellVM = FormCellVM(placeholder: "Latitude", text: text, type: .latitude)
        if !validLatitude {
            cellVM.error = "Latitude value must be between -90 and 90"
        }
        return cellVM
    }
    
    var longitudeCellVM: CellVM {
        let text = longitude != nil ? String(format: "%f", longitude!) : ""
        var cellVM = FormCellVM(placeholder: "Longitude", text: text, type: .longitude)
        if !validLongitude {
            cellVM.error = "Longitude value must be between -180 and 180"
        }
        return cellVM
    }
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? = BaseHeaderVM(title: "Coordinates")
    
    var cellsVMs: [CellVM] {
        return [latitudeCellVM, longitudeCellVM].compactMap{ $0 }
    }
    
    var valid: Bool {
        latitude != nil && longitude != nil && validLongitude && validLatitude
    }
    
    //MARK:- Update
    func update(with place: Place) {
        if let mountain = place as? Mountain {
            latitude = mountain.coordinates?.latitude
            longitude = mountain.coordinates?.longitude
        } else if let lake = place as? Lake {
            latitude = lake.coordinates?.latitude
            longitude = lake.coordinates?.longitude
        }
    }
    
    func update(cellType: PlaceDetailsCellType, with data: String) {
        switch cellType {
        case .latitude:
            latitude = (data as NSString).doubleValue
        case .longitude:
            longitude = (data as NSString).doubleValue
        default: break
        }
    }
}
