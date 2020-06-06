import UIKit

class ButtonCell: UITableViewCell {
    @IBAction func buttonTap(_ sender: UIButton) {
    }
}

extension ButtonCell: CellView {
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? ButtonCellVM {

        }
    }
}
