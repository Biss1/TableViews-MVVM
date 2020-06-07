import UIKit

protocol PlaceDetailsVCDelegate: BaseTableVMDelegate {
    func searchForPlace()
    func showPicker()
}

class PlaceDetailsVC: BaseTableVC<PlaceDetailsVM> {
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        registerKeyboardNotifications()
        updateHeader()
    }
    
    override func setupTableView() {
        let cells = [FormCell.self, SwitchCell.self, PickerCell.self, ButtonCell.self]
        tableView.register(cells: cells)
        tableView.register(headerFooterViews: [BaseHeader.self])
    }
    
    override func setupViewModel() {
        viewModel = PlaceDetailsVM(delegate: self)
        if let place = place {
            viewModel.update(with: place)
        }
    }
    
    override func updateView() {
        super.updateView()
        updateHeader()
    }
    
    func updateHeader() {
        placeNameLabel.text = viewModel.placeName
        if let imageName = viewModel.placeImage {
            placeImage.image = UIImage(named: imageName)
        } else {
            placeImage.isHidden = true
        }
    }
    
    // MARK:- Picker view handling
    func setupPickerView() {
        pickerView.isHidden = true
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @IBAction func donePickerViewTapped() {
        pickerView.isHidden = true
    }
    
    // MARK:- Keyboard notifications
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
        let bottomInset = keyboardSize.height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: bottomInset, right: 0.0);
        self.tableView.contentInset = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = .zero
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
