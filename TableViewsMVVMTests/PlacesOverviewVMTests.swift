import XCTest
@testable import TableViewsMVVM

class PlacesOverviewVMTests: XCTestCase {

    let delegate = MockBaseTableVMDelegate()
    
    override func setUp() {}

    override func tearDown() {}

    func testGroupByCategoryList() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.groupingType = .byCategory
        
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfSections(), 3)
        
        // first section
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfRows(for: 0), 6)
        XCTAssert(placesOverviewVM.tableViewModel.headerTypeFor(section: 0) == BaseHeader.self)
        XCTAssert(placesOverviewVM.tableViewModel.cellTypeFor(section: 0, row: 1) == PlaceImageCell.self)
        
        // second section
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfRows(for: 1), 4)
        XCTAssert(placesOverviewVM.tableViewModel.headerTypeFor(section: 1) == BaseHeader.self)
        XCTAssert(placesOverviewVM.tableViewModel.cellTypeFor(section: 1, row: 1) == PlaceImageCell.self)
        
        // third section
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfRows(for: 2), 3)
        XCTAssert(placesOverviewVM.tableViewModel.headerTypeFor(section: 2) == BaseHeader.self)
        XCTAssert(placesOverviewVM.tableViewModel.cellTypeFor(section: 2, row: 1) == PlaceImageCell.self)
    }
    
    func testGroupByCountryList() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.groupingType = .byCountry
        
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfSections(), 13)
        
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfRows(for: 0), 1)
        XCTAssert(placesOverviewVM.tableViewModel.headerTypeFor(section: 0) == BaseHeader.self)
        XCTAssert(placesOverviewVM.tableViewModel.cellTypeFor(section: 0, row: 0) == PlaceCell.self)
        
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfRows(for: 1), 1)
        XCTAssert(placesOverviewVM.tableViewModel.headerTypeFor(section: 1) == BaseHeader.self)
        XCTAssert(placesOverviewVM.tableViewModel.cellTypeFor(section: 1, row: 0) == PlaceCell.self)
        
        XCTAssertEqual(placesOverviewVM.tableViewModel.numberOfRows(for: 2), 1)
        XCTAssert(placesOverviewVM.tableViewModel.headerTypeFor(section: 2) == BaseHeader.self)
        XCTAssert(placesOverviewVM.tableViewModel.cellTypeFor(section: 2, row: 0) == PlaceCell.self)
    }

    func testVisitedPlaces() {
        
    }
    
    func testGroupByCategoryListContent() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.groupingType = .byCategory

        // first section
        let headerVM = placesOverviewVM.tableViewModel.headerViewModel(section: 0) as? BaseHeaderVM
        XCTAssertEqual(headerVM?.title, "Lakes")
        let firstCellVM = placesOverviewVM.tableViewModel.cellViewModelFor(section: 0, row: 0) as? PlaceImageCellVM
        XCTAssertEqual(firstCellVM?.name, "Ohrid lake")
        XCTAssertEqual(firstCellVM?.imageName, "ohrid_lake")
        
        let secondCellVM = placesOverviewVM.tableViewModel.cellViewModelFor(section: 0, row: 1) as? PlaceImageCellVM
        XCTAssertEqual(secondCellVM?.name, "Crater Lake")
        XCTAssertEqual(secondCellVM?.imageName, "crater_lake")
        
        // second section
        let headerVM2 = placesOverviewVM.tableViewModel.headerViewModel(section: 1) as? BaseHeaderVM
        XCTAssertEqual(headerVM2?.title, "Mountains")
        let firstCellVM2 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 1, row: 1) as? PlaceImageCellVM
        XCTAssertEqual(firstCellVM2?.name, "Mount Fuji")
        XCTAssertEqual(firstCellVM2?.imageName, "mount-fuji")
        
        let secondCellVM2 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 1, row: 2) as? PlaceImageCellVM
        XCTAssertEqual(secondCellVM2?.name, "Huayna Picchu")
        XCTAssertEqual(secondCellVM2?.imageName, "hauyna-picchu")
    }
    
    func testGroupByCountryListContent() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.groupingType = .byCountry

        // first section
        let headerVM = placesOverviewVM.tableViewModel.headerViewModel(section: 0) as? BaseHeaderVM
        XCTAssertEqual(headerVM?.title, "Bolivia")
        let cellVM1 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 0, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM1?.name, "Laguna Colorada")
        
        // second section
        let headerVM2 = placesOverviewVM.tableViewModel.headerViewModel(section: 1) as? BaseHeaderVM
        XCTAssertEqual(headerVM2?.title, "Brazil")
        let cellVM2 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 1, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM2?.name, "Amazon")
    }
    
    func testRatings() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.groupingType = .byCountry
        
        let cellVM1 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 8, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM1?.ratings, 1)
        XCTAssertEqual(cellVM1?.stars, 5)
        
        let cellVM2 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 9, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM2?.ratings, 2)
        XCTAssertEqual(cellVM2?.stars, 5)
        
        let cellVM3 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 12, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM3?.ratings, 2)
        XCTAssertEqual(cellVM3?.stars, 4)
    }
    
    func testCategoryForPlace() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.groupingType = .byCountry
        
        let cellVM1 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 0, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM1?.placeIconName, "icon_lake")
        
        let cellVM2 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 1, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM2?.placeIconName, "icon_river")
        
        let cellVM4 = placesOverviewVM.tableViewModel.cellViewModelFor(section: 5, row: 0) as? PlaceCellVM
        XCTAssertEqual(cellVM4?.placeIconName, "icon_mountain")
    }
    
    func testSetupPlaceCell() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.groupingType = .byCountry
        
        let cellVM = placesOverviewVM.tableViewModel.cellViewModelFor(section: 8, row: 0)
        let cellType = placesOverviewVM.tableViewModel.cellTypeFor(section: 8, row: 0)
        
        let tableView = UITableView()
        tableView.register(cells: [PlaceCell.self])
        let placeCell = tableView.dequeueReusableCell(at: IndexPath(row: 0, section: 0), of: PlaceCell.self)!
        
        placeCell.setup(viewModel: cellVM)
        
        XCTAssertTrue(cellType == PlaceCell.self)
        XCTAssertEqual(placeCell.nameLabel?.text, "Dead Sea")
    }
    
    func testHeader() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        let headerType = placesOverviewVM.tableViewModel.headerTypeFor(section: 0)
        
        XCTAssertTrue(headerType == BaseHeader.self)
    }
    
    func testSwitchGroupingType() {
        let placesOverviewVM = PlacesOverviewVM(delegate: delegate)
        placesOverviewVM.switchGroupingType()
        
        XCTAssertTrue(delegate.updateViewCalled)
    }
}

class MockBaseTableVMDelegate: BaseTableVMDelegate {
    var updateViewCalled = false
    
    func updateView() {
        updateViewCalled = true
    }
}
