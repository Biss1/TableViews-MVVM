import XCTest
@testable import TableViewsMVVM

class PlacesOverviewVMTests: XCTestCase {

    var placesOverviewVM = PlacesOverviewVM(delegate: BaseTestDelegate())
    
    override func setUp() {}

    override func tearDown() {}

    func testGroupByTypeCells() {
    }
    
    func testGroupByCountryCells() {
    }

    func testVisitedPlaces() {
        
    }
    
    func testGroupByCategoryCellsContent() {
    }
    
    func testGroupByCountryCellsContent() {
    }
    
    func testRatings() {
        
    }
    
    func testPlaceCategory() {
        
    }
}

class BaseTestDelegate: BaseTableVMDelegate {
    func updateView() {
        
    }
}
