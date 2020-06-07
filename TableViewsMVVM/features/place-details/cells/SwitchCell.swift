import UIKit

class SwitchCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    var type: PlaceDetailsCellType!
    var cellDelegate: CellDelegate?
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        (cellDelegate as? PlaceDetailsVMUpdateDelegate)?.update(cellType: type, with: sender.isOn)
    }
}

extension SwitchCell: CellView {
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? SwitchCellVM {
            titleLabel.text = vm.title
            type = vm.type
            switchControl.isOn = vm.switchValue
        }
    }
}
