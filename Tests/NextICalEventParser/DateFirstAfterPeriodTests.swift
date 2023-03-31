//
// Created by Brian Henry on 3/11/23.
//

@testable import NextICalEventParser

import XCTest

class DateFirstAfterTests: XCTestCase {

    func testByYear() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let startingDate = dateFormatter.date(from: "2021-03-10T04:05:06")!
        let referenceDate = dateFormatter.date(from: "2023-03-10T04:05:06")!

        let expected = dateFormatter.date(from: "2024-03-10T04:05:06")!

        let advancedDate = startingDate.firstAfterPeriod(years: 10, after: referenceDate)

        XCTAssertEqual( expected, advancedDate )
    }
}
