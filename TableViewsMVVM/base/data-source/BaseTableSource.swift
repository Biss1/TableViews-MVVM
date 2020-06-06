import UIKit

public protocol TableSource {
    var tableData: [TableSectionVM] { set get }
    
    func numberOfSections() -> Int
    func numberOfRows(for section: Int) -> Int
    
    func headerTypeFor(section: Int) -> UITableViewHeaderFooterView.Type?
    func headerViewModel(section: Int) -> HeaderVM?
    
    func footerTypeFor(section: Int) -> UITableViewHeaderFooterView.Type?
    func footerViewModel(section: Int) -> FooterVM?
    
    func cellTypeFor(section: Int, row: Int) -> UITableViewCell.Type
    func cellViewModelFor(section: Int, row: Int) -> CellVM
}


public struct TableSectionVM {
    var headerVM: HeaderVM?
    var footerVM: FooterVM?
    var cellData: [CellVM]
}

public struct BaseTableSource: TableSource {
    public var tableData: [TableSectionVM]
    
    public func numberOfSections() -> Int {
        tableData.count
    }
    
    public func numberOfRows(for section: Int) -> Int {
        tableData[section].cellData.count
    }
    
    public func headerTypeFor(section: Int) -> UITableViewHeaderFooterView.Type? {
        guard let header = tableData[section].headerVM else { return nil }
        
        if let ht = header as? IdentifiableHeaderVM {
            return ht.headerType
        }
        return UITableViewHeaderFooterView.self
    }
    
    public func headerViewModel(section: Int) -> HeaderVM? {
        return tableData[section].headerVM
    }
    
    public func footerTypeFor(section: Int) -> UITableViewHeaderFooterView.Type? {
        guard let footer = tableData[section].footerVM else { return nil }
        
        if let ft = footer as? IdentifiableFooterVM {
            return ft.footerType
        }
        return UITableViewHeaderFooterView.self
    }
    
    public func footerViewModel(section: Int) -> FooterVM? {
        tableData[section].footerVM
    }
    
    public func cellTypeFor(section: Int, row: Int) -> UITableViewCell.Type {
        let cell = tableData[section].cellData[row]
        if let ct = cell as? IdentifiableCellVM {
            return ct.cellType
        }
        return UITableViewCell.self
    }
    
    public func cellViewModelFor(section: Int, row: Int) -> CellVM {
        tableData[section].cellData[row]
    }
}

extension BaseTableSource {
    
    func viewModel(for indexPath: IndexPath) -> CellVM {
        return tableData[indexPath.section].cellData[indexPath.row]
    }
    
}
