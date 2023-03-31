//
// Created by Brian Henry on 3/11/23.
//

@testable import NextICalEventParser

import XCTest



class DateAdvancedByTests: XCTestCase {

    func testBySecond() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let date = dateFormatter.date(from: "2023-03-11T04:05:06")!

        let expected = dateFormatter.date(from: "2023-03-11T04:05:08")!

        let advancedDate = date.advancedBy(seconds: 2)

        XCTAssertEqual( expected, advancedDate )
    }

    func testByYear() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let date = dateFormatter.date(from: "2023-03-11T04:05:06")!

        let expected = dateFormatter.date(from: "2025-03-11T04:05:06")!

        let advancedDate = date.advancedBy(years:2)

        XCTAssertEqual( expected, advancedDate )
    }


}