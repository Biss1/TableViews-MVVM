import XCTest
@testable import TableViewsMVVM

class PlaceDetailsCellsTests: XCTestCase {
 
    func testFormCellSetup() {
        let formCellVM = FormCellVM(title: "Title", placeholder: "Placeholder", text: "Text", error: "Error", type: .name)
        
        let tableView = UITableView()
        tableView.register(cells: [FormCell.self])
        let cell = tableView.dequeueReusableCell(at: IndexPath(row: 0, section: 0), of: FormCell.self)!
        
        cell.setup(viewModel: formCellVM)
        
        XCTAssertEqual(cell.titleLabel?.text, "Title")
    }
    
    func testFormCellWithoutError() {
        let formCellVM = FormCellVM(title: nil, placeholder: "Placeholder", text: "Text", error: nil, type: .name)
        
        let tableView = UITableView()
        tableView.register(cells: [FormCell.self])
        let cell = tableView.dequeueReusableCell(at: IndexPath(row: 0, section: 0), of: FormCell.self)!
        
        cell.setup(viewModel: formCellVM)
        
        XCTAssertEqual(cell.titleLabel?.isHidden, true)
        XCTAssertEqual(cell.errorLabel?.isHidden, true)
    }
    
    func testPickerCellSetup() {
        let cellVM = PickerCellVM(title: "Title", value: "Value")
        
        let tableView = UITableView()
        tableView.register(cells: [PickerCell.self])
        let cell = tableView.dequeueReusableCell(at: IndexPath(row: 0, section: 0), of: PickerCell.self)!
        
        cell.setup(viewModel: cellVM)
        
        XCTAssertEqual(cell.titleLabel?.text, "Title")
        XCTAssertEqual(cell.errorLabel?.isHidden, true)
    }
    
    func testPickerCellWithError() {
        let cellVM = PickerCellVM(title: "Title", value: "Value", type: .countryPicker, error: "Error")
        
        let tableView = UITableView()
        tableView.register(cells: [PickerCell.self])
        let cell = tableView.dequeueReusableCell(at: IndexPath(row: 0, section: 0), of: PickerCell.self)!
        
        cell.setup(viewModel: cellVM)
        
        XCTAssertEqual(cell.titleLabel?.text, "Title")
        XCTAssertEqual(cell.errorLabel?.isHidden, false)
        XCTAssertEqual(cell.errorLabel?.text, "Error")
    }
    
    func testSwitchCellSetup() {
        let cellVM = SwitchCellVM(title: "Title", switchValue: true, type: .coordinatesSwitch)
        
        let tableView = UITableView()
        tableView.register(cells: [SwitchCell.self])
        let cell = tableView.dequeueReusableCell(at: IndexPath(row: 0, section: 0), of: SwitchCell.self)!
        
        cell.setup(viewModel: cellVM)
        
        XCTAssertEqual(cell.titleLabel?.text, "Title")
        XCTAssertEqual(cell.switchControl.isOn, true)
    }
    
    func testButtonCellSetup() {
        let cellVM = ButtonCellVM()
        
        let tableView = UITableView()
        tableView.register(cells: [ButtonCell.self])
        let cell = tableView.dequeueReusableCell(at: IndexPath(row: 0, section: 0), of: ButtonCell.self)!
        
        cell.setup(viewModel: cellVM)
        
        XCTAssertEqual(cell.cellButton.titleLabel?.text, "Save")
        XCTAssertEqual(cell.cellButton.isEnabled, true)
    }
}
