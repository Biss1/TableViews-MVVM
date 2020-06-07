import UIKit

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeId = (tableView.cellForRow(at: indexPath) as? CellView)?.id
        performSegue(withIdentifier: "placeDetailsSegue", sender: placeId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedPlaceId = sender as? Int,
            let place = DataService.getPlaceById(selectedPlaceId) {
            (segue.destination as? PlaceDetailsVC)?.place = place
        }
    }
}
