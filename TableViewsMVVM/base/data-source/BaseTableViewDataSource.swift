import UIKit

public class BaseTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: BaseTableSource
//    var firstResponderCell: FirstRespondableCell?
    var cellHeights: [IndexPath : CGFloat] = [:]
    var cellDelegate: CellDelegate?
    
    init(vm: BaseTableSource) {
        viewModel = vm
    }
    
    func update(viewModel: BaseTableSource) {
        self.viewModel = viewModel
    }
    
    public  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerType = viewModel.headerTypeFor(section: section) else { return nil }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(of: headerType) else {
            return nil
        }
        
        guard let headerData = viewModel.headerViewModel(section: section) else { return nil }
        
        (header as? HeaderView)?.setup(viewModel: headerData)
        
        return header
    }
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let headerView = self.tableView(tableView, viewForHeaderInSection: section) {
            return headerView.compressedHeight()
        }
        return 0.001
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerType = viewModel.footerTypeFor(section: section) else { return nil }
        
        guard let footer = tableView.dequeueReusableHeaderFooterView(of: footerType) else {
            return nil
        }
        
        guard let footerData = viewModel.footerViewModel(section: section) else { return nil }
        
        (footer as? FooterView)?.setup(viewModel: footerData)
        
        return footer
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let footerView = self.tableView(tableView, viewForFooterInSection: section) {
            return footerView.frame.height
        }
        return 0.001
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(for: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellTypeFor(section: indexPath.section, row: indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(at: indexPath, of: cellType) else {
            return UITableViewCell()
        }
        
        let cellData = viewModel.cellViewModelFor(section:indexPath.section,
                                                  row: indexPath.row)
        (cell as? CellView)?.setup(viewModel: cellData)
        (cell as? CellView)?.cellDelegate = cellDelegate
//        if let validFirstResponderCell = (cell as? FirstRespondableCell)?.firstRespondableCellVM.shouldBecomeFirstResponder {
//            if validFirstResponderCell {
//                firstResponderCell = cell as? FirstRespondableCell
//            }
//        }
//        
//        if let selectionStyle = (cell as? UnselectableCell)?.unselectableStyle {
//            cell.selectionStyle = selectionStyle
//        }

        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeights[indexPath] ?? tableView.estimatedRowHeight
    }
    
    public func rectFor(_ tableView: UITableView, indexPath: IndexPath) -> CGRect {
        tableView.rectForRow(at: indexPath)
    }
    
}

public protocol CellView: class {
    var cellDelegate: CellDelegate? { get set }
    var id: Int? { get set }
    func setup(viewModel: CellVM)
}
public extension CellView {
    // makes the cellDelegate optional so we don't have to add it in all the cells
    var cellDelegate: CellDelegate? {
        get { nil }
        set { }
    }
    var id: Int? {
        get { nil }
        set { }
    }
}

public protocol HeaderView {
    func setup(viewModel: HeaderVM)
}

public protocol FooterView {
    func setup(viewModel: FooterVM)
}

public protocol CellDelegate: class {}

