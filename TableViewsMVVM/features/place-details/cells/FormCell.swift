import UIKit

class FormCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
}

extension FormCell: CellView {
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? FormCellVM {
            textField.placeholder = vm.placeholder
            textField.text = vm.text
        }
    }
}
