//
// Created by Brian Henry on 3/12/23.
//

@testable import NextICalEventParser

import XCTest
import ICalSwift
import AsyncHTTPClient
import AsyncObjects
import NIOConcurrencyHelpers


final class IntegrationTests: XCTestCase {

    func testRemoteURLFoundation() {

        let myURLString = "https://calendar.google.com/calendar/ical/admin%40sacbikekitchen.org/public/basic.ics"

        let myURL = URL(string: myURLString)!

        var icsString = try! String(contentsOf: myURL, encoding: .utf8)

        icsString = icsString.replacingOccurrences(of: "\r", with: "")

        let parser = ICalParser()
        let calendar = parser.parseCalendar(ics: icsString)
        let nextEvent = calendar?.next()

        let nextTime = nextEvent?.nextTime()

        guard let nextEvent = ICalParser().parseCalendar(ics: icsString)?.next() else {
            XCTFail()
            return
        }

        XCTAssertTrue(true)
    }

    func testRemoteURLNIO() async throws {

        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let request = HTTPClientRequest(url: "https://calendar.google.com/calendar/ical/admin%40sacbikekitchen.org/public/basic.ics")
        let response = try await httpClient.execute(request, timeout: .seconds(30))

        print("HTTP head", response)
        if response.status != .ok {
            // handle remote error
//            return
        }
        var body = try await response.body.collect(upTo: 1024 * 1024) // 1 MB
        // handle body

        let actualBody = body.readString(length: body.readableBytes)
        print("before")
        print(actualBody ?? "")
        print("after")

        try! await httpClient.shutdown()

//
//
//        let myURLString = "https://calendar.google.com/calendar/ical/admin%40sacbikekitchen.org/public/basic.ics"
//
////        let myURL = URL(string: myURLString)!
//
//        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
//
//        let request = HTTPClientRequest(url: myURLString)
//        let response = try! await httpClient.execute(request, timeout: .seconds(30))
//        print("HTTP head", response)
//        if response.status == .ok {
//
//        } else {
//            // handle remote error
//        }
//
////        let body = try! await response.body.collect(upTo: 1024 * 1024 * 5) // 1 MB
//        let body = response.body
//
//        let data = body






//        var icsString = body.description
//        let bytes = body.flatMap { $0.getData(at: 0, length: $0.readableBytes) }
//        let data = try JSONDecoder().decode(RequestInfo.self, from: bytes!)

//        var asd = body.readString(length: 1024*1024*5)




//
//        let operation = TaskOperation<String> {
//            let value: Result<String, Never> = try! await future.result!
//
//            return try! value.get()
//        }
//        operation.start()
//        operation.waitUntilFinished()
//        let str = try! operation.result.



//        XCTAssertEqual("result", value)

//        let operation = TaskOperation {
//
//            let request = HTTPClientRequest(url: myURLString)
//            let response = try! await httpClient.execute(request, timeout: .seconds(30))
//            print("HTTP head", response)
//            if response.status == .ok {
//
//            } else {
//                // handle remote error
//            }
//            var body = try! await response.body.collect(upTo: 1024 * 1024 * 5) // 5 MB
//            guard var icsString = body.readString(length: body.readableBytes) else {
//                return
//            }
//
//            try await httpClient.shutdown()
//
//            icsString = icsString.replacingOccurrences(of: "\r", with: "")
//
//            let parser = ICalParser()
//            let calendar = parser.parseCalendar(ics: icsString)
//            let nextEvent = calendar?.next()
//
//            let nextTime = nextEvent?.nextTime()
//
//        }
//        operation.start()
//
//        operation.waitUntilFinished()
//
//        print(icsString)


//        waitForExpectations(timeout: 60)

        XCTAssertTrue(true)
    }
}

