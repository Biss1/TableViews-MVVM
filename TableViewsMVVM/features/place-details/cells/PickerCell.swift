import UIKit

class PickerCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
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
            type = vm.type
            
            let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                           action: #selector(PickerCell.valueLabelTap(sender:)))
            valueLabel.isUserInteractionEnabled = true
            valueLabel.addGestureRecognizer(gestureRecognizer)
        }
    }
}
