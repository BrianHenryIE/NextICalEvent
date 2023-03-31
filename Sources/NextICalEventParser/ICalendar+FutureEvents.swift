//
// Created by Brian Henry on 3/11/23.
//

import Foundation
import ICalSwift

extension ICalendar {

    func futureEvents(from compareDate: Date = Date()) -> [ICalEvent] {
        events.filter { event in event.isFuture(from: compareDate) }
    }

}