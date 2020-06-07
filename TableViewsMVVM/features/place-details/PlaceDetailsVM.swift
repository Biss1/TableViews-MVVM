// option for new place - all empty, edit place - prefilled data from the previous screen

protocol PlaceDetailsVMUpdateDelegate: CellDelegate {
    func update(cellType: PlaceDetailsCellType, with data: String)
    func update(cellType: PlaceDetailsCellType, with data: Bool)
    func showPicker(cellType: PlaceDetailsCellType)
}

class PlaceDetailsVM: BaseTableVM {
    var headerTitle: String = ""
    var baseInfoSection = BaseInfoSectionVM()
    var placeDetailsSection = PlaceDetailsSectionVM()
    var coordinatesSection = CoordinatesSectionVM()
    var locationInfoSection = LocationInfoSectionVM()
    var buttonSection = ButtonSection()
    var placeName: String {
        baseInfoSection.name
    }
    var placeImage: String?
    var saveButtonEnabled: Bool { baseInfoSection.valid &&
        (!locationInfoSection.showCoordinates || coordinatesSection.valid) }
    
    var tableViewModel: BaseTableSource {
        var sections: [SectionVM] = [baseInfoSection];
        if baseInfoSection.category != .none {
            sections.append(placeDetailsSection)
        }
        sections.append(locationInfoSection)
        if locationInfoSection.showCoordinates {
            sections.append(coordinatesSection)
        }
        sections.append(buttonSection)
        
        let sectionsVMs = sections.map{ TableSectionVM(headerVM: $0.headerVM, cellData: $0.cellsVMs)}
        
        return BaseTableSource(tableData: sectionsVMs)
    }
    
    var delegate: PlaceDetailsVCDelegate?
    
    var showPickerView: Bool = true
    var pickerType: PickerType = .categoryPicker
    var pickerData: [String] {
        switch pickerType {
        case .categoryPicker:
            return PlaceCategory.allCases.map { $0.rawValue }
        default:
            return [""]
        }
    }
    
    init(delegate: PlaceDetailsVCDelegate) {
        self.delegate = delegate
    }
    
    func update(with place: Place) {
        placeImage = place.image
        baseInfoSection.update(with: place)
        placeDetailsSection.update(with: place)
        locationInfoSection.update(with: place)
        coordinatesSection.update(with: place)
        buttonSection.enabled = saveButtonEnabled
        delegate?.updateView()
    }
    
    func update(pickerRow: Int) {
        if let category = PlaceCategory(rawValue: pickerData[pickerRow]) {
            baseInfoSection.category = category
            placeDetailsSection.category = category
            delegate?.updateView()
        }
    }
}

extension PlaceDetailsVM: PlaceDetailsVMUpdateDelegate {
    func update(cellType: PlaceDetailsCellType, with data: String) {
        switch cellType {
        case .name:
            baseInfoSection.name = data
        case .description:
            baseInfoSection.description = data
        case .latitude, .longitude:
            coordinatesSection.update(cellType: cellType, with: data)
        default:
            placeDetailsSection.update(cellType: cellType, with: data)
        }
        buttonSection.enabled = saveButtonEnabled
        delegate?.updateView()
    }
    
    func update(cellType: PlaceDetailsCellType, with data: Bool) {
        switch cellType {
        case .coordinatesSwitch:
            locationInfoSection.showCoordinates = data
        default:
            break;
        }
        buttonSection.enabled = saveButtonEnabled
        delegate?.updateView()
    }
    
    func showPicker(cellType: PlaceDetailsCellType) {
        switch cellType {
        case .categoryPicker:
            pickerType = .categoryPicker
        case .countryPicker:
            pickerType = .countryPicker
        default: break;
        }
        buttonSection.enabled = saveButtonEnabled
        delegate?.showPicker()
    }
}

protocol SectionVM {
    var headerVM: HeaderVM? { get }
    var cellsVMs: [CellVM] { get }
}

enum PickerType {
    case categoryPicker
    case countryPicker
}

enum PlaceDetailsCellType {
    case none
    case name
    case description
    case categoryPicker
    case coordinatesSwitch
    case countryPicker
    case length
    case width
    case area
    case depth
    case source
    case mouth
    case basinSize
    case averageDischarge
    case peak
    case elevation
    case orogeny
    case residenceTime
    case lakeType
    case primaryInflows
    case primaryOutflows
    case latitude
    case longitude
}
