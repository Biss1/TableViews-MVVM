import UIKit

class PlaceImageCell: UITableViewCell, CellView {
    var id: Int?
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var visitedIcon: UIImageView!
    
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? PlaceImageCellVM {
            id = vm.id
            placeImage.image = UIImage(named: vm.imageName)
            nameLabel.text = vm.name
            visitedIcon.isHidden = !vm.showVisitedIcon
        }
    }
}
