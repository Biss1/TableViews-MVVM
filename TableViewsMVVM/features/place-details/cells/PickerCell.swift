import UIKit

class PickerCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    var type: PlaceDetailsCellType = .categoryPicker
    var cellDelegate: CellDelegate?
    
    @objc func valueLabelTap(sender:UITapGestureRecognizer) {
        (cellDelegate as? PlaceDetailsVMUpdateDelegate)?.showPicker(cellType: type)
    }
}

extension PickerCell: CellView {
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? PickerCellVM {
            titleLabel.text = vm.title
            valueLabel.text = vm.value
            if let error = vm.error {
                errorLabel.text = error
                errorLabel.isHidden = false
            } else {
                errorLabel.isHidden = true
            }
            type = vm.type
            
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(PickerCell.valueLabelTap(sender:)))
            valueLabel.isUserInteractionEnabled = true
            valueLabel.addGestureRecognizer(gestureRecognizer)
        }
    }
}
