import XCTest
@testable import TableViewsMVVM

class BaseClassesTests: XCTestCase {
    
    func testTableCellDeque() {
        let tableView = UITableView()
        tableView.register(cells: [FormCell.self])
        
        let tableSource = BaseTableSource(tableData: MockData.mockTableData)
        let dataSource = BaseTableViewDataSource(vm: tableSource)
        
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is FormCell)
    }
    
    func testTableFooterDeque() {
        let tableView = UITableView()
        tableView.register(headerFooterViews: [BaseFooter.self])
        
        let tableSource = BaseTableSource(tableData: MockData.mockTableDataFooter)
        let dataSource = BaseTableViewDataSource(vm: tableSource)
        
        let footer = dataSource.tableView(tableView, viewForFooterInSection: 0)
        XCTAssertTrue(footer is BaseFooter)
    }
    
    func testDefaultFooter() {
        let tableSource = BaseTableSource(tableData: MockData.mockDefaultTableData)
        
        XCTAssertTrue(tableSource.footerTypeFor(section: 0) == UITableViewHeaderFooterView.self)
        XCTAssertTrue(tableSource.footerViewModel(section: 0) is MockFooterVM)
    }
    
    func testIdentifiableFooter() {
        let tableSource = BaseTableSource(tableData: MockData.mockTableData)
        
        XCTAssertTrue(tableSource.footerTypeFor(section: 0) == UITableViewHeaderFooterView.self)
        XCTAssertTrue(tableSource.footerViewModel(section: 0) is MockIdentifiableFooterVM)
    }
    
    func testDefaultViewForHeader() {
        let tableSource = BaseTableSource(tableData: MockData.mockDefaultTableData)
        
        XCTAssertTrue(tableSource.headerTypeFor(section: 0) == UITableViewHeaderFooterView.self)
        XCTAssertTrue(tableSource.headerViewModel(section: 0) is MockHeaderVM)
    }
    
    func testIdentifiableViewForHeader() {
        let tableSource = BaseTableSource(tableData: MockData.mockTableData)
        
        XCTAssertTrue(tableSource.headerTypeFor(section: 0) == UITableViewHeaderFooterView.self)
        XCTAssertTrue(tableSource.headerViewModel(section: 0) is MockIdentifiableHeaderVM)
    }
    
    func testDefaultCellType() {
        let tableSource = BaseTableSource(tableData: MockData.mockDefaultTableData)
        
        XCTAssertTrue(tableSource.cellTypeFor(section: 0, row: 0) == UITableViewCell.self)
    }
    
    func testBaseTableVM() {
        let tableVM = MockBaseTableVM()
        
        XCTAssertEqual(tableVM.hasRefresh, false)
        XCTAssertEqual(tableVM.headerSubtitle, "")
        XCTAssertNil(tableVM.delegate)
    }
}

struct MockCellVM: CellVM {}

struct MockHeaderVM: HeaderVM {}

struct MockFooterVM: FooterVM {}

struct MockIdentifiableHeaderVM: HeaderVM, IdentifiableHeaderVM {}

struct MockIdentifiableFooterVM: FooterVM, IdentifiableFooterVM {}

struct MockIdentifiableCellVM: CellVM, IdentifiableCellVM {
    var cellType: UITableViewCell.Type {
        FormCell.self
    }
}

struct MockBaseTableVM: BaseTableVM {
    var headerTitle: String = "Mock header"
    
    var tableViewModel: BaseTableSource = BaseTableSource(tableData: MockData.mockTableData)
}

struct MockData {
    static var mockDefaultTableData: [TableSectionVM] {
        [TableSectionVM(headerVM: MockHeaderVM(), footerVM: MockFooterVM(), cellData: [MockCellVM()])]
    }
    
    static var mockTableData: [TableSectionVM] {
        [TableSectionVM(headerVM: MockIdentifiableHeaderVM(), footerVM: MockIdentifiableFooterVM(), cellData: [MockIdentifiableCellVM()])]
    }
    
    static var mockTableDataFooter: [TableSectionVM] {
        [TableSectionVM(headerVM: MockIdentifiableHeaderVM(), footerVM: BaseFooterVM(title: ""), cellData: [MockIdentifiableCellVM()])]
    }
}
