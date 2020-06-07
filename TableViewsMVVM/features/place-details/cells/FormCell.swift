import UIKit

class FormCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var cellType: PlaceDetailsCellType = .none
    var cellDelegate: CellDelegate?
}

extension FormCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        (cellDelegate as? PlaceDetailsVMUpdateDelegate)?.update(cellType: cellType,
                                                                with: textField.text ?? "")
    }
}

extension FormCell: CellView {
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? FormCellVM {
            textField.placeholder = vm.placeholder
            textField.text = vm.text
            if let title = vm.title {
                titleLabel.isHidden = false
                titleLabel.text = title
            } else {
                titleLabel.isHidden = true
            }
            textField.addDoneToolbar()
            if let error = vm.error {
                errorLabel.isHidden = false
                errorLabel.text = error
            } else {
                errorLabel.isHidden = true
            }
            cellType = vm.type
        }
    }
}
