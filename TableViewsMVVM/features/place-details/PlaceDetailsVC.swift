class PlaceDetailsVC: BaseTableVC<PlaceDetailsVM> {
    
    override func setupTableView() {
        let cells = [FormCell.self, SwitchCell.self, PickerCell.self]
         tableView.register(cells: cells)
         tableView.register(headerFooterViews: [BaseHeader.self])
     }
     
     override func setupViewModel() {
        viewModel = PlaceDetailsVM(delegate: self)
     }
    
}
