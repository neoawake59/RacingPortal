//
//  RaceListPortalViewControllerTest.swift
//  RaceListPortalTests
//
//  Created by Nishant Bhardwaj on 1/7/2023.
//

import XCTest
import Foundation
@testable import RaceListPortal

final class RaceListPortalViewControllerTest: XCTestCase {
    
    var viewControllerUnderTest: RaceListViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        
        self.viewControllerUnderTest = RaceListViewController()
        
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
        
        viewControllerUnderTest.raceList = [RaceSummary(raceID: "11", raceName: "N Go", raceNumber: 133, meetingID: "dfe3", meetingName: "ff4", categoryID: "dfdf", advertisedStart: AdvertisedStart(seconds: 120), raceForm: RaceForm(distance: 122, distanceType: DistanceType(id: "fdf", name: "sff", shortName: "fsdfsdf", iconURI: "dfdf"), distanceTypeID: "dfdsf", trackCondition: DistanceType(id: "fdf", name: "sff", shortName: "fsdfsdf", iconURI: "dfdf"), trackConditionID: "dfdf", weather: DistanceType(id: "fdf", name: "sff", shortName: "fsdfsdf", iconURI: "dfdf"), weatherID: "FFDg", raceComment: "FGf", additionalData: "fgf", generated: 333, silkBaseURL: "FGG", raceCommentAlternative: "GFDG"), venueID: "FDF", venueName: "GGG", venueState: "GG", venueCountry: "")]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
        
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RaceListCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "RaceListCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {
        let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RaceListCell
        XCTAssertEqual(cell0?.raceNameLabel.text, "ff4 : 133")
        
    }
}
