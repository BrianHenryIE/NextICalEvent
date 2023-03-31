//
// Created by Brian Henry on 3/11/23.
//

import Foundation
import ICalSwift

extension ICalendar {

    public func next(from compareDate: Date = Date()) -> ICalEvent? {
        let unsortedFutureEvents = futureEvents().filter { event in
            if event.nextTime() != nil {
                return true
            } else {
                return false
            }
        }

        // Jesus, I dont' know what I should do here with nil and comparisons, but the tests pass!
        let sortedFutureEvents = unsortedFutureEvents.sorted { event1, event2 in
            guard let time1 = event1.nextTime() else {
                return true
            }
            guard let time2 = event2.nextTime() else {
                return true
            }
            return time1 < time2
        }

        return sortedFutureEvents.first
    }
}