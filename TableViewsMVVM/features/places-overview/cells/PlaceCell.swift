import UIKit

class PlaceCell: UITableViewCell {
    var id: Int?
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeTypeImage: UIImageView!
    @IBOutlet weak var ratingView: UIStackView!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    var images: [UIImageView] = []
    
    func starImages() -> [UIImageView] {
        if images.count > 0 {
            return images
        }
        var images: [UIImageView] = []
        for _ in 0...4 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
            imageView.image = UIImage(named: "star")
            images.append(imageView)
        }
        return images
    }
}

extension PlaceCell: CellView {
    
    func setup(viewModel: CellVM) {
        if let vm = viewModel as? PlaceCellVM {
            id = vm.id
            placeImage.image = UIImage(named: vm.imageName)
            nameLabel.text = vm.name
            placeTypeImage.image = UIImage(named: vm.placeIconName)

            for subview in ratingView.subviews {
                ratingView.removeArrangedSubview(subview)
            }
            ratingsLabel.text = ""
            if vm.stars > 0 {
                for i in 0...vm.stars - 1 {
                    ratingView.addArrangedSubview(starImages()[i])
                }
                ratingsLabel.text = String(format: "%d ratings", vm.ratings)
            }
        }
    }
}
