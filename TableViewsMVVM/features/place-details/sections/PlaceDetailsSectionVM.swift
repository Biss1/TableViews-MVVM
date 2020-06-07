import Foundation

class PlaceDetailsSectionVM: SectionVM {
    var category: PlaceCategory = .none
    
    var length: Float?
    var width: Float?
    var area: Float?
    var depth: Float?

    // river
    var source: String?
    var mouth: String?
    var basinSize: Float?
    var averageDischarge: Float?
    
    // mountain
    var peak: String?
    var elevation: Float?
    var orogeny: String?
    
    // lake
    var residenceTime: Int?
    var lakeType: String?
    var primaryInflows: String?
    var primaryOutflows: String?
    
    // MARK: - Cells VM
    var lengthCellVM: CellVM {
        let title = category == .lake ? "Max length (km)" : "Length (km)"
        let text = length != nil ? String(format: "%.2f", length!) : ""
        return FormCellVM(title: title, placeholder: "Enter length in km", text: text, type: .length)
    }
    
    var widthCellVM: CellVM {
        let title = category != .mountain ? "Max width (km)" : "Width (km)"
        let text = width != nil ? String(format: "%.2f", width!) : ""
        return FormCellVM(title: title, placeholder: "Enter width", text: text, type: .width)
    }
    
    var areaCellVM: CellVM? {
        if category == .river {
            return nil
        }
        let title = category == .lake ? "Surface area (km2)" : "Area (km2)"
        let text = area != nil ? String(format: "%.2f", area!) : ""
        return FormCellVM(title: title, placeholder: "Enter area in km2", text: text, type: .area)
    }
    
    var elevationCellVM: CellVM? {
        if category == .mountain {
            let text = elevation != nil ? String(format: "%.2f", elevation!) : ""
            return FormCellVM(title: "Elevation",
                              placeholder: "Enter elevation level",
                              text: text,
                              type: .elevation)
        }
        return nil
    }
    
    var peakCellVM: CellVM? {
        if category == .mountain {
            return FormCellVM(title: "Highest peak", placeholder: "Peak", text: peak ?? "", type: .peak)
        }
        return nil;
    }
    
    var orogenyCellVM: CellVM? {
        if category == .mountain {
            return FormCellVM(title: "Orogeny",
                              placeholder: "Alpine, Uralian, Mediterranean Ridge, Caledonian...",
                              text: orogeny ?? "",
                              type: .orogeny)
        }
        return nil;
    }
    
    var basinSizeCellVM: CellVM? {
        if category == .river {
            let text = basinSize != nil ? String(format: "%.2f", basinSize!) : ""
            return FormCellVM(title: "Basin size (km2)",
                              placeholder: "Enter basin size",
                              text: text,
                              type: .basinSize)
        }
        return nil;
    }
    
    var sourceCellVM: CellVM? {
        if category == .river {
            return FormCellVM(title: "Source",
                              placeholder: "Enter source",
                              text: source ?? "",
                              type: .source)
        }
        return nil;
    }
    
    var mouthCellVM: CellVM? {
        if category == .river {
            return FormCellVM(title: "Mouth",
                              placeholder: "Enter mouth",
                              text: mouth ?? "",
                              type: .mouth)
        }
        return nil;
    }
    
    var averageDischargeCellVM: CellVM? {
        if category == .river {
            let text = averageDischarge != nil ? String(format: "%.2f", averageDischarge!) : ""
            return FormCellVM(title: "Average discharge (L/s)",
                              placeholder: "Enter average discharge in litres per second",
                              text: text,
                              type: .averageDischarge)
        }
        return nil;
    }
    
    var lakeTypeCellVM: CellVM? {
        if category == .lake {
            return FormCellVM(title: "Lake type",
                              placeholder: "volcanic, crater, glacial, tectonic..",
                              text: lakeType ?? "",
                              type: .lakeType)
        }
        return nil
    }
    
    var inflowsCellVM: CellVM? {
        if category == .lake {
            return FormCellVM(title: "Primary inflows",
                              placeholder: "Enter the primary inflows",
                              text: primaryInflows ?? "",
                              type: .primaryInflows)
        }
        return nil
    }
    
    var outflowsCellVM: CellVM? {
        if category == .lake {
            return FormCellVM(title: "Primary outflows",
                              placeholder: "Enter the primary outflows",
                              text: primaryOutflows ?? "",
                              type: .primaryOutflows)
        }
        return nil
    }
    
    var depthCellVM: CellVM? {
        if category == .lake || category == .river {
            let text = depth != nil ? String(format: "%.0f", depth!) : ""
            return FormCellVM(title: "Max depth (m)",
                              placeholder: "Enter max depth",
                              text: text,
                              type: .depth)
        }
        return nil
    }
    
    var residenceTimeCellVM: CellVM? {
        if category == .lake {
            return FormCellVM(title: "Residence time (years)",
                              placeholder: "Enter residence time",
                              text: String(format: "%d", residenceTime ?? 0),
                              type: .residenceTime)
        }
        return nil
    }
    
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
        default: break;
        }
        return BaseHeaderVM(title: title)
    }
    
    var cellsVMs: [CellVM] {
        [lengthCellVM, widthCellVM, areaCellVM, depthCellVM,
        peakCellVM, elevationCellVM, orogenyCellVM, // mountain
        lakeTypeCellVM, inflowsCellVM, outflowsCellVM, residenceTimeCellVM, // lake
        sourceCellVM, mouthCellVM, averageDischargeCellVM, basinSizeCellVM // river
            ].compactMap{ $0 }
    }
    
    //MARK:- Update
    func update(with place: Place) {
        category = place.category
        if let lake = place as? Lake {
            lakeType = lake.lakeType
            primaryInflows = lake.primaryInflows
            primaryOutflows = lake.primaryOutflows
            length = lake.maxLength
            width = lake.maxWidth
            depth = lake.maxDepth
            area = lake.surfaceArea
            residenceTime = lake.residenceTime
        } else if let river = place as? River {
            width = river.maxWidth
            length = river.length
            basinSize = river.basinSize
            source = river.source
            mouth = river.mouth
            depth = river.maxDepth
            averageDischarge = river.averageDischarge
        } else if let mountain = place as? Mountain {
            width = mountain.width
            length = mountain.length
            area = mountain.area
            orogeny = mountain.orogeny
            peak = mountain.highestPeak
            elevation = mountain.elevation
        }
    }
    
    func update(cellType: PlaceDetailsCellType, with data: String) {
        switch cellType {
        case .length:
            length = (data as NSString).floatValue
        case .width:
            width = (data as NSString).floatValue
        case .area:
            area = (data as NSString).floatValue
        case .depth:
            depth = (data as NSString).floatValue
        case .source:
            source = data
        case .mouth:
            mouth = data
        case .basinSize:
            basinSize = (data as NSString).floatValue
        case .averageDischarge:
            averageDischarge = (data as NSString).floatValue
        case .peak:
            peak = data
        case .elevation:
            elevation = (data as NSString).floatValue
        case .orogeny:
            orogeny = data
        case .residenceTime:
            residenceTime = Int(data)
        case .lakeType:
            lakeType = data
        case .primaryInflows:
            primaryInflows = data
        case .primaryOutflows:
            primaryOutflows = data
        default:
            break;
        }
    }
}
