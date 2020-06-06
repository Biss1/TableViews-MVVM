import UIKit

struct BaseHeaderVM: HeaderVM {
    var title: String
}

extension BaseHeaderVM: IdentifiableHeaderVM {
    public var headerType: UITableViewHeaderFooterView.Type {
        BaseHeader.self
    }
}

class BaseHeader: UITableViewHeaderFooterView, HeaderView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(viewModel: HeaderVM) {
        if let vm = viewModel as? BaseHeaderVM {
            self.titleLabel.text = vm.title
        }
    }
}
