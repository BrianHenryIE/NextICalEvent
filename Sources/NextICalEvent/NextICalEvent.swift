//
// Created by Brian Henry on 3/12/23.
//

import AWSLambdaRuntime
import ICalSwift
import NextICalEventParser
import Foundation
import AWSLambdaEvents
import AsyncHTTPClient

struct EventResponse: Codable {

    let title: String

    let utcTime: Date
}

@main
struct NextICalEventHandler: SimpleLambdaHandler {
    typealias Output = EventResponse

    func handle(_ request: APIGatewayV2Request, context: LambdaContext) async throws -> EventResponse {

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