struct BaseInfoSectionVM: SectionVM {
    var name: String = ""
    var description: String = ""
    var category: PlaceCategory
    var validate: Bool = false
    
    var nameCellVM: CellVM {
        FormCellVM(placeholder: "Enter name", text: "")
    }
    
    var categoryCellVM: CellVM {
        PickerCellVM(title: "Category", value: category.description(), type: .categoryPicker)
    }
    
    var descriptionCellVM: CellVM {
        FormCellVM(placeholder: "Enter description", text: "")
        
//        if description.isEmpty && validate {
//            FormCellVM(placeholder: "Show additional error", text: "")
//        }
        //TODO:
        // if description is empty show error cell or something
    }
    
    var valid: Bool {
        !name.isEmpty && !description.isEmpty
    }
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? = BaseHeaderVM(title: "General")
    
    var cellsVMs: [CellVM] {
        return [nameCellVM, descriptionCellVM, categoryCellVM].compactMap{ $0 }
    }
}
