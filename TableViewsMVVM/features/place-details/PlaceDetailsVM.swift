class PlaceDetailsVM: BaseTableVM {
    var headerTitle: String = ""
    var tableViewModel: BaseTableSource {
        let section = TableSectionVM(headerVM: BaseHeaderVM(title: "Form"),
                                     cellData: [FormCellVM(), FormCellVM(), FormCellVM(),
                                                               SwitchCellVM(), PickerCellVM()])
        return BaseTableSource(tableData: [section])
    }
    var delegate: BaseTableVMDelegate?
    
    init(delegate: BaseTableVMDelegate) {
        self.delegate = delegate
    }
}
