import UIKit

struct BaseFooterVM: FooterVM {
    var title: String
}

extension BaseFooterVM: IdentifiableFooterVM {
    public var footerType: UITableViewHeaderFooterView.Type {
        BaseFooter.self
    }
}

class BaseFooter: UITableViewHeaderFooterView, FooterView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(viewModel: FooterVM) {
        if let vm = viewModel as? BaseFooterVM {
            self.titleLabel.text = vm.title
        }
    }
}
