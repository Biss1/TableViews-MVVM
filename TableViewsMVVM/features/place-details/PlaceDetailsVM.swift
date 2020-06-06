
protocol PlaceDetailsVMUpdateDelegate: CellDelegate {
    func update(cellType: PlaceDetailsCellType, with data: String)
    func update(cellType: PlaceDetailsCellType, with data: Bool)
    func showPicker(cellType: PlaceDetailsCellType)
}

class PlaceDetailsVM: BaseTableVM {
    var headerTitle: String = ""
    var baseInfoSection = BaseInfoSectionVM(category: .river)
    var categoryInfoSection = CategoryInfoSectionVM()
    var coordinatesSection = CoordinatesSectionVM()
    var countryInfoSection = CountryInfoSectionVM()
    var buttonSection = ButtonSection()
    
    
    var tableViewModel: BaseTableSource {
        var sections: [SectionVM] = [baseInfoSection,
                                     categoryInfoSection,
                                     countryInfoSection];
        if countryInfoSection.showCoordinates {
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
    
    func update(pickerRow: Int) {
        if let category = PlaceCategory(rawValue: pickerData[pickerRow]) {
            categoryInfoSection.category = category
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
        default:
            break;
        }
    }
    
    func update(cellType: PlaceDetailsCellType, with data: Bool) {
        switch cellType {
        case .coordinatesSwitch:
            countryInfoSection.showCoordinates = data
        default:
            break;
        }
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
    case name
    case description
    case categoryPicker
    case coordinatesSwitch
    case countryPicker
}
