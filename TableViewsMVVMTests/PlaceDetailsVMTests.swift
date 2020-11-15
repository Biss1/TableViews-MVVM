import XCTest
@testable import TableViewsMVVM

class PlaceDetailsVMTests: XCTestCase {
    
    let cellsDelegate = PlaceDetailsVMUpdateMockDelegate()
    let vmDelegate = PlaceDetailsVCMockDelegate()
    
    func testPlaceName() {
        let place = DataService.places[0]
        
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)
        
        XCTAssertEqual(placeDetailsVM.placeName, place.name)
    }
    
    func testBaseInfoSectionContent() {
        let place = DataService.places[0]
        
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)
        
        let firstCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 0, row: 0) as? FormCellVM
        let cellType = placeDetailsVM.tableViewModel.cellTypeFor(section: 0, row: 0)
        XCTAssertTrue(cellType == FormCell.self)
        XCTAssertEqual(place.name, firstCell?.text)
        
        let secondCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 0, row: 1) as? FormCellVM
        XCTAssertEqual(place.description, secondCell?.text)
        
        let thirdCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 0, row: 2) as? PickerCellVM
        XCTAssertEqual(place.category.description(), thirdCell?.value)
    }
    
    func testBaseInfoSectionNameValidation() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(cellType: .name, with: "")
        placeDetailsVM.update(cellType: .description, with: "Description")
        
        let cellVM = placeDetailsVM.tableViewModel.cellViewModelFor(section: 0, row: 0) as? FormCellVM
        XCTAssertEqual("", cellVM?.text)
        XCTAssertEqual("Name is mandatory", cellVM?.error)
    }
    
    func testBaseInfoSectionPlaceTypeValidation() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(pickerRow: 0) // category: none
        
        let cellVM = placeDetailsVM.tableViewModel.cellViewModelFor(section: 0, row: 2) as? PickerCellVM
        XCTAssertEqual("None", cellVM?.value)
        XCTAssertEqual("Please choose a category", cellVM?.error)
    }
    
    func testShowPlaceDetailSection() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(pickerRow: 0) // category: none
        XCTAssertEqual((placeDetailsVM.placeDetailsSection.headerVM as? BaseHeaderVM)?.title, "")
        
        XCTAssertEqual(placeDetailsVM.tableViewModel.numberOfSections(), 3)
        
        placeDetailsVM.update(pickerRow: 1) // category: lake
        XCTAssertEqual(placeDetailsVM.tableViewModel.numberOfSections(), 4)
        let header = placeDetailsVM.tableViewModel.headerViewModel(section: 1) as? BaseHeaderVM
        XCTAssertEqual(header?.title, "Lake info")
    }
    
    func testPlaceDetailsSectionContentForRiver() {
        let place = DataService.places[6] as! River
        
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)
        
        let firstCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 0) as? FormCellVM
        XCTAssertEqual("Length (km)", firstCell?.title)
        XCTAssertEqual("6575.00", firstCell?.text)
        
        let secondCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 1) as? FormCellVM
        XCTAssertEqual("Max width (km)", secondCell?.title)
        XCTAssertEqual("100.00", secondCell?.text)
        
        let thirdCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 2) as? FormCellVM
        XCTAssertEqual("Max depth (m)", thirdCell?.title)
        XCTAssertEqual("100", thirdCell?.text)
        
        let fourthCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 3) as? FormCellVM
        XCTAssertEqual("Source", fourthCell?.title)
        XCTAssertEqual(place.source, fourthCell?.text)
    }
    
    func testPlaceDetailsSectionContentForRiverWithoutData() {
        let place = DataService.places[7] as! River
        
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)
        
        let firstCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 0) as? FormCellVM
        XCTAssertEqual("", firstCell?.text)
    }
    
    func testPlaceDetailsSectionUpdatesForRiver() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(cellType: .length, with: "45.21")
        placeDetailsVM.update(cellType: .width, with: "45.21")
        placeDetailsVM.update(cellType: .depth, with: "45.21")
        placeDetailsVM.update(cellType: .source, with: "45.21")
        placeDetailsVM.update(cellType: .mouth, with: "45.21")
        placeDetailsVM.update(cellType: .basinSize, with: "45.21")
        
        // TODO: test the updates
    }
    
    func testUpdatePropertyForRiver() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(cellType: .averageDischarge, with: "452")
        
        XCTAssertEqual(placeDetailsVM.placeDetailsSection.averageDischarge, 452)
    }
    
    func testShowingCategoryPicker() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        
        // should not show picker for name
        placeDetailsVM.showPicker(cellType: .name)
        XCTAssertFalse(vmDelegate.showPicker)
        
        // should show picker for category
        placeDetailsVM.showPicker(cellType: .categoryPicker)
        
        XCTAssertTrue(vmDelegate.showPicker)
        XCTAssertNotNil(placeDetailsVM.pickerData)
    }
    
    func testPlaceDetailsSectionContentForMountain() {
        let place = DataService.places[9] as! Mountain
        
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)
        
        let firstCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 0) as? FormCellVM
        XCTAssertEqual("Length (km)", firstCell?.title)
        XCTAssertEqual("1200.00", firstCell?.text)
        
        let secondCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 1) as? FormCellVM
        XCTAssertEqual("Width (km)", secondCell?.title)
        XCTAssertEqual("250.00", secondCell?.text)
        
        let thirdCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 2) as? FormCellVM
        XCTAssertEqual("Area (km2)", thirdCell?.title)
        XCTAssertEqual("200000.00", thirdCell?.text)
        
        let fourthCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 3) as? FormCellVM
        XCTAssertEqual("Highest peak", fourthCell?.title)
        XCTAssertEqual(place.highestPeak, fourthCell?.text)
        
        let fifthCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 4) as? FormCellVM
        XCTAssertEqual("Elevation", fifthCell?.title)
        XCTAssertEqual("4808.73", fifthCell?.text)
        
        let sixthCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 5) as? FormCellVM
        XCTAssertEqual("Orogeny", sixthCell?.title)
        XCTAssertEqual(place.orogeny, sixthCell?.text)
    }
    
    func testPlaceDetailsSectionContentForMountainWithoutData() {
        let place = DataService.places[10] as! Mountain
        
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)
        
        let firstCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 0) as? FormCellVM
        XCTAssertEqual("", firstCell?.text)
    }
    
    func testPlaceDetailsSectionUpdatesForMountain() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(cellType: .length, with: "45.21")
        placeDetailsVM.update(cellType: .width, with: "45.21")
        placeDetailsVM.update(cellType: .area, with: "45.21")
        placeDetailsVM.update(cellType: .peak, with: "45.21")
        placeDetailsVM.update(cellType: .elevation, with: "45.21")
        placeDetailsVM.update(cellType: .orogeny, with: "45.21")
        placeDetailsVM.update(cellType: .countryPicker, with: "45.21")
        
        // TODO: test the updates
    }
    
    func testPlaceDetailsSectionContentForLake() {
        
    }
    
    func testPlaceDetailsSectionUpdatesForLake() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(cellType: .length, with: "45.21")
        placeDetailsVM.update(cellType: .width, with: "45.21")
        placeDetailsVM.update(cellType: .area, with: "45.21")
        placeDetailsVM.update(cellType: .primaryInflows, with: "45.21")
        placeDetailsVM.update(cellType: .primaryOutflows, with: "45.21")
        placeDetailsVM.update(cellType: .residenceTime, with: "45.21")
        placeDetailsVM.update(cellType: .lakeType, with: "45.21")
        
        // TODO: test the updates
    }
    
    func testLocationInfoSectionContent() {
        let place = DataService.places[0]
        
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)
        
        let firstCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 2, row: 0) as? PickerCellVM
        XCTAssertEqual(place.country, firstCell?.value)
        let cellType = placeDetailsVM.tableViewModel.cellTypeFor(section: 2, row: 0)
        XCTAssertTrue(cellType == PickerCell.self)
        
        let secondCell = placeDetailsVM.tableViewModel.cellViewModelFor(section: 2, row: 1) as? SwitchCellVM
        XCTAssertEqual(true, secondCell?.switchValue)
        let switchCellType = placeDetailsVM.tableViewModel.cellTypeFor(section: 2, row: 1)
        XCTAssertTrue(switchCellType == SwitchCell.self)
    }
    
    func testLocationInfoSectionShowCoordinatesSwitch() {
        let place = DataService.places[9]
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)

        // shown for mountain and lake
        XCTAssertEqual(placeDetailsVM.tableViewModel.numberOfRows(for: 2), 2)
    }
    
    func testLocationInfoSectionHideCoordinatesSwitch() {
        let place = DataService.places[6]
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(with: place)

        // not shown for river
        XCTAssertEqual(placeDetailsVM.tableViewModel.numberOfRows(for: 2), 1)
    }
    
    func testLocationInfoSectionUpdateCountry() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.showPicker(cellType: .countryPicker)
        
        // check if the delegate for showing the picker has been called
        XCTAssert(vmDelegate.showPicker)
        // update the picker value to the first country 'USA'
        let index = placeDetailsVM.pickerData.firstIndex{ $0 == "USA" }!
        placeDetailsVM.update(pickerRow: index)
        
        let cellVM = placeDetailsVM.tableViewModel.cellViewModelFor(section: 1, row: 0) as? PickerCellVM
        XCTAssertEqual("USA", cellVM?.value)
    }
    
    func testCoordinatesSectionShown() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        XCTAssertEqual(placeDetailsVM.tableViewModel.numberOfSections(), 3)
        
        // turn on the coordinate switch
        placeDetailsVM.update(cellType: .coordinatesSwitch, with: true)
        placeDetailsVM.update(cellType: .name, with: false)
        // coordinate section is shown
        XCTAssertEqual(placeDetailsVM.tableViewModel.numberOfSections(), 4)
        
        // check the section header
        let header = placeDetailsVM.tableViewModel.headerViewModel(section: 2) as? BaseHeaderVM
        XCTAssertEqual(header?.title, "Coordinates")
    }
    
    func testCoordinatesSectionContent() {
        
    }
    
    func testCoordinatesSectionValidationLatitude() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        // show coordinate section and update latitude value
        placeDetailsVM.update(cellType: .coordinatesSwitch, with: true)
        placeDetailsVM.update(cellType: .latitude, with: "3283.32")
        
        // check if value is updated and error shown
        let cellVM = placeDetailsVM.tableViewModel.cellViewModelFor(section: 2, row: 0) as? FormCellVM
        XCTAssertEqual("3283.320000", cellVM?.text)
        XCTAssertEqual("Latitude value must be between -90 and 90", cellVM?.error)
    }
    
    func testCoordinatesSectionValidationLongitude() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        placeDetailsVM.update(cellType: .coordinatesSwitch, with: true)
        placeDetailsVM.update(cellType: .longitude, with: "3283.32")
        
        let cellVM = placeDetailsVM.tableViewModel.cellViewModelFor(section: 2, row: 1) as? FormCellVM
        XCTAssertEqual("3283.320000", cellVM?.text)
        XCTAssertEqual("Longitude value must be between -180 and 180", cellVM?.error)
    }
    
    func testButtonSectionSaveEnabled() {
        let placeDetailsVM = PlaceDetailsVM(delegate: vmDelegate)
        // name and category are mandatory
        XCTAssertFalse(placeDetailsVM.saveButtonEnabled)
        
        // fill name and choose category
        placeDetailsVM.update(cellType: .name, with: "Name")
        placeDetailsVM.showPicker(cellType: .categoryPicker)
        placeDetailsVM.update(pickerRow: 1)
        
        XCTAssertTrue(placeDetailsVM.saveButtonEnabled)
        
        let buttonCellType = placeDetailsVM.tableViewModel.cellTypeFor(section: 3, row: 0)
        XCTAssertTrue(buttonCellType == ButtonCell.self)
    }
    
    func testButtonSectionSaveDisabled() {

    }
}

class PlaceDetailsVMUpdateMockDelegate: PlaceDetailsVMUpdateDelegate {
    var updateCellType: PlaceDetailsCellType?
    var updateData: String?
    
    func update(cellType: PlaceDetailsCellType, with data: String) {
        updateCellType = cellType
        updateData = data
    }
    
    func update(cellType: PlaceDetailsCellType, with data: Bool) {
        updateCellType = cellType
    }
    
    func showPicker(cellType: PlaceDetailsCellType) {
        updateCellType = cellType
    }
}

class PlaceDetailsVCMockDelegate: PlaceDetailsVCDelegate {
    var showPicker = false
    var updateViewCalled = false
    
    func searchForPlace() {
        
    }
    
    func showPicker(selectedRow: Int) {
        showPicker = true
    }
    
    func updateView() {
        updateViewCalled = true
    }
}
