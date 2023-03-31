//
// Created by Brian Henry on 3/11/23.
//

import Foundation

@testable import NextICalEventParser

import XCTest
import ICalSwift

final class ICalEventIsFutureTests: XCTestCase {

    func testRecurringNoEndTime() {

        let icsEvent = """
                      BEGIN:VEVENT
                      DTSTART;TZID=America/Los_Angeles:20220731T090000
                      DTEND;TZID=America/Los_Angeles:20220731T130000
                      RRULE:FREQ=WEEKLY;BYDAY=SU
                      DTSTAMP:20230228T064200Z
                      UID:35ud1gj8dqjtvi21fptbi0cr8d_R20220731T160000@google.com
                      CREATED:20210707T205219Z
                      DESCRIPTION:Shop open to the public today from 9am-1pm. We are currently ac
                      cepting donations and doing sales/free kids bikes. Please visit our website
                      for more info-- https://www.sacbikekitchen.org/
                      LAST-MODIFIED:20220718T161042Z
                      LOCATION:1915 I St\\, Sacramento\\, CA 95811\\, USA
                      SEQUENCE:0
                      STATUS:CONFIRMED
                      SUMMARY:SBK open for sales\\, 9am-1pm
                      TRANSP:OPAQUE
                      END:VEVENT
                      """

        let parser = ICalParser()

        let parsed = parser.parseEvents(ics: icsEvent)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: "2023-03-11")!

        let result = parsed.first?.isFuture(from: date);

        XCTAssertTrue(result ?? false)
    }

    func testPastRecurringEventDenotedByNumberOfRecurrences() {

        let icsEvent = """
                       BEGIN:VEVENT
                       DTSTART;TZID=America/Los_Angeles:20170102T180000
                       DTEND;TZID=America/Los_Angeles:20170102T200000
                       DTSTAMP:20230228T064200Z
                       UID:12ctjclg4hdgdsfd1ic52k9r8g@google.com
                       RECURRENCE-ID;TZID=America/Los_Angeles:20170102T180000
                       CREATED:20110517T050453Z
                       DESCRIPTION:We will not be having our monthly meeting this month due to tod
                        ay being a holiday. Our next monthly meeting will be held the first Monday
                        in February as scheduled.
                       LAST-MODIFIED:20180827T172104Z
                       LOCATION:Sacramento Bicycle Kitchen - 1915 I Street
                       SEQUENCE:1
                       STATUS:CONFIRMED
                       SUMMARY:Monthly Meeting Canceled
                       TRANSP:OPAQUE
                       END:VEVENT
                       """

        let parser = ICalParser()

        let parsed = parser.parseEvents(ics: icsEvent)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: "2023-03-11")!

        let result = parsed.first?.isFuture(from: date);

        XCTAssertFalse(result ?? true)
    }

    func testInPast() {

        let icsEvent = """
                       BEGIN:VEVENT
                       DTSTART:20081101T010000Z
                       DTEND:20081101T030000Z
                       DTSTAMP:20230228T064200Z
                       UID:lp00c2hb92s326fuge46beglp8@google.com
                       RECURRENCE-ID:20081025T010000Z
                       CREATED:20080625T003707Z
                       DESCRIPTION:*Meet at Fremont Park\\, 16th & P in midtown\\n*Meet at 5:30pm\\,
                        ride at 6pm\\\\\\n\\nCritical Mass is a monthly event held in cities around the
                         world to promote bicycle culture and cyclists' rights to the road. There i
                        s no central organization or leadership. Rides are organized by the partici
                        pants through discussion and consensus. If you enjoy your bike\\, community\\
                        , and planet\\, join us every month to show your support.\\n\\n*Last Friday of
                         Every Month (for 2008: 6/27\\, 7/25\\, 8/29\\, 9/26\\, 10/31\\, 11/28\\, 12/26)\\
                        n\\n*More info:\\n\\nhttp://sacramentocriticalmass.googlepages.com\\n\\nhttp://w
                        ww.myspace.com/sacramentocriticalmass
                       LAST-MODIFIED:20230114T085158Z
                       LOCATION:16th st. & P st. Sacramento\\, CA
                       SEQUENCE:0
                       STATUS:CONFIRMED
                       SUMMARY:Critical Mass
                       TRANSP:OPAQUE
                       END:VEVENT
                       """

        let parser = ICalParser()

        let parsed = parser.parseEvents(ics: icsEvent)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: "2023-03-11")!

        let result = parsed.first?.isFuture(from: date);

        XCTAssertFalse(result ?? true)
    }

    func testInPast2() {

        let icsEvent = """
                        BEGIN:VEVENT
                        DTSTART:20080830T010000Z
                        DTEND:20080830T030000Z
                        DTSTAMP:20230228T064200Z
                        UID:lp00c2hb92s326fuge46beglp8@google.com
                        RECURRENCE-ID:20080823T010000Z
                        CREATED:20080625T003707Z
                        DESCRIPTION:NA
                        LAST-MODIFIED:20230114T085158Z
                        LOCATION:NA
                        SEQUENCE:0
                        STATUS:CONFIRMED
                        SUMMARY:Critical Mass
                        TRANSP:OPAQUE
                        END:VEVENT
                        """
        let parser = ICalParser()

        let parsed = parser.parseEvents(ics: icsEvent)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: "2023-03-11")!

        let event = parsed.first!

        let result = event.isFuture(from: date);

        XCTAssertFalse(result)
    }

    func testInPast3() {

        let icsEvent = """
                        BEGIN:VEVENT
                        DTSTART;TZID=America/Los_Angeles:20080627T180000
                        DTEND;TZID=America/Los_Angeles:20080627T200000
                        RRULE:FREQ=MONTHLY;WKST=SU;UNTIL=20081128T075959Z;BYDAY=4FR
                        DTSTAMP:20230228T064200Z
                        UID:lp00c2hb92s326fuge46beglp8@google.com
                        CREATED:20080625T003707Z
                        DESCRIPTION:*Meet at Fremont Park\\, 16th & P in midtown\\n*Meet at 5:30pm\\,
                        ride at 6pm\\\\\\n\\nCritical Mass is a monthly event held in cities around the
                         world to promote bicycle culture and cyclists' rights to the road. There i
                        s no central organization or leadership. Rides are organized by the partici
                        pants through discussion and consensus. If you enjoy your bike\\, community\\
                        , and planet\\, join us every month to show your support.\\n\\n*Last Friday of
                         Every Month (for 2008: 6/27\\, 7/25\\, 8/29\\, 9/26\\, 10/31\\, 11/28\\, 12/26)\\
                        n\\n*More info:\\n\\nhttp://sacramentocriticalmass.googlepages.com\\n\\nhttp://w
                        ww.myspace.com/sacramentocriticalmass
                        LAST-MODIFIED:20230114T085158Z
                        LOCATION:16th st. & P st. Sacramento\\, CA
                        SEQUENCE:0
                        STATUS:CONFIRMED
                        SUMMARY:Critical Mass
                        TRANSP:OPAQUE
                        END:VEVENT
                        """
        let parser = ICalParser()

        let parsed = parser.parseEvents(ics: icsEvent)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: "2023-03-11")!

        let event = parsed.first!

        let result = event.isFuture(from: date);

        XCTAssertFalse(result)
    }

    func testARecurringEvent() {

        let icsEvent = """
                       BEGIN:VEVENT
                       DTSTART;TZID=America/Los_Angeles:20060719T180000
                       DTEND;TZID=America/Los_Angeles:20060719T210000
                       RRULE:FREQ=DAILY;COUNT=1
                       DTSTAMP:20230228T064200Z
                       UID:ernpturjvitks4fb5a296hjlkc@google.com
                       CREATED:20060712T223548Z
                       DESCRIPTION:C'mon in and fix your bike or get a newish one.
                       LAST-MODIFIED:20230114T085121Z
                       LOCATION:The Shop
                       SEQUENCE:2
                       STATUS:CONFIRMED
                       SUMMARY:Shop is Open
                       TRANSP:OPAQUE
                       END:VEVENT
                       """

        let parser = ICalParser()

        let parsed = parser.parseEvents(ics: icsEvent)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: "2023-03-11")!

        let event = parsed.first!

        let result = event.isFuture(from: date);

        XCTAssertFalse(result)
    }
}
