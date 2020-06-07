class ButtonSection: SectionVM {
    var enabled: Bool = false
    
    var buttonCellVM: CellVM {
        ButtonCellVM(isEnabled: enabled)
    }
    
    //MARK:- SectionVM
    var headerVM: HeaderVM? = nil
    
    var cellsVMs: [CellVM] {
        return [buttonCellVM].compactMap{ $0 }
    }
}
