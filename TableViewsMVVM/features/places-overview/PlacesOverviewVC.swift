class PlacesOverviewVC: BaseTableVC<PlacesOverviewVM> {
    
    override func setupTableView() {
        let cells = [PlaceCell.self, PlaceImageCell.self]
        tableView.register(cells: cells)
        tableView.register(headerFooterViews: [BaseHeader.self])
    }
    
    override func setupViewModel() {
       viewModel = PlacesOverviewVM(delegate: self)
    }
    
    @IBAction func switchGrouping(_ sender: Any) {
        viewModel.switchGroupingType()
    }
    
}
