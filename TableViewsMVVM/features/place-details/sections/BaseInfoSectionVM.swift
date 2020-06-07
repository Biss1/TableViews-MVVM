class BaseInfoSectionVM: SectionVM {
    var name: String = ""
    var description: String = ""
    var category: PlaceCategory = .none
    var validate: Bool = false
    
    //MARK: - Cells VM
    var nameCellVM: CellVM {
        FormCellVM(placeholder: "Enter name", text: name, type: .name)
    }
    
    var categoryCellVM: CellVM {
        PickerCellVM(title: "Category", value: category.description(), type: .categoryPicker)
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
        !name.isEmpty
    }
    
    // MARK:- Update
    func update(with place: Place) {
        name = place.name
        description = place.description ?? ""
        category = place.category
    }
}
