import UIKit

class ButtonCell: UITableViewCell {
    @IBOutlet weak var cellButton: UIButton!
    
    @IBAction func buttonTap(_ sender: UIButton) {
    }
}

extension ButtonCell: CellView {
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? ButtonCellVM {
            cellButton.alpha = vm.isEnabled ? 1 : 0.5
            cellButton.isEnabled = vm.isEnabled
        }
    }
}
