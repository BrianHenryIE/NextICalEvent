//
// Created by Brian Henry on 3/12/23.
//

import AWSLambdaRuntime
import ICalSwift
import NextICalEventParser
import Foundation
import AsyncHTTPClient

struct Input: Codable {
    let number: Double
}

struct Number: Codable {
    let result: Double
}

@main
struct NextICalEventHandler: LambdaHandler {
    typealias Event = Input
    typealias Output = EventResponse

    init(context: LambdaInitializationContext) async {

    }

    func handle(_ event: Input, context: LambdaContext) async throws -> Output {

        let myURLString = "https://calendar.google.com/calendar/ical/admin%40sacbikekitchen.org/public/basic.ics"

        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        let request = HTTPClientRequest(url: myURLString)
        let response = try await httpClient.execute(request, timeout: .seconds(30))

        if response.status != .ok {
            // handle remote error
//            return
        }
        var body = try await response.body.collect(upTo: 1024 * 1024) // 1 MB
        // handle body

        var icsString = body.readString(length: body.readableBytes)!

        try await httpClient.shutdown()

        icsString = icsString.replacingOccurrences(of: "\r", with: "")

        let parser = ICalParser()
        let calendar = parser.parseCalendar(ics: icsString)
        let nextEvent = calendar?.next()

        let nextTime = nextEvent?.nextTime()

        return EventResponse(title: nextEvent?.summary ?? "", utcTime: nextTime!)
    }
}