import UIKit

protocol PlaceDetailsVCDelegate: BaseTableVMDelegate {
    func searchForPlace()
    func showPicker()
}

class PlaceDetailsVC: BaseTableVC<PlaceDetailsVM> {
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
    }
    
    override func setupTableView() {
        let cells = [FormCell.self, SwitchCell.self, PickerCell.self, ButtonCell.self]
        tableView.register(cells: cells)
        tableView.register(headerFooterViews: [BaseHeader.self])
    }
    
    override func setupViewModel() {
        viewModel = PlaceDetailsVM(delegate: self)
    }
    
    override func updateView() {
        super.updateView()
    }
    
    func setupPickerView() {
        pickerView.isHidden = true
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Payment details delegate
extension PlaceDetailsVC: PlaceDetailsVCDelegate {
    func showPicker() {
        pickerView.isHidden = false
    }
    
    func searchForPlace() {
        // TODO: here is fetched the data, after we receive the date vm is updated
    }
}

// MARK: - Picker view
extension PlaceDetailsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.update(pickerRow: row)
    }
}
