class BaseInfoSectionVM: SectionVM {
    // MARK: - Properties
    var name: String = ""
    var description: String = ""
    var category: PlaceCategory = .none
    
    var validateFields: [PlaceDetailsCellType] = []
    
    //MARK: - Cells VM
    var nameCellVM: CellVM {
        var error: String? = nil
        if validateFields.contains(.name) && name.isEmpty {
            error = "Name is mandatory"
        }
        return FormCellVM(placeholder: "Enter name", text: name, error: error, type: .name)
    }
    
    var categoryCellVM: CellVM {
        var error: String? = nil
        if validateFields.contains(.categoryPicker) && category == .none {
            error = "Please choose a category"
        }
        return PickerCellVM(title: "Category",
                            value: category.description(),
                            type: .categoryPicker,
                            error: error)
    }
    
    var descriptionCellVM: CellVM {
        FormCellVM(placeholder: "Enter description", text: description, type: .description)
    }
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? = BaseHeaderVM(title: "General")
    
    var cellsVMs: [CellVM] {
        return [nameCellVM, descriptionCellVM, categoryCellVM].compactMap{ $0 }
    }
    
    var valid: Bool {
        !name.isEmpty && category != .none
    }
    
    // MARK:- Update
    func update(with place: Place) {
        name = place.name
        description = place.description ?? ""
        category = place.category
    }
    
    func update(cellType: PlaceDetailsCellType, with data: String) {
        switch cellType {
        case .name:
            name = data
            validateFields.append(cellType)
        case .description:
            description = data
        default: return
        }
    }
    
    func update(category: PlaceCategory) {
        self.category = category
        validateFields.append(.categoryPicker)
    }
}
