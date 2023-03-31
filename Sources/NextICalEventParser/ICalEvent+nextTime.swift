//
// Created by Brian Henry on 3/11/23.
//

import Foundation
import ICalSwift

extension ICalEvent {

    public func nextTime(from compareDate: Date = Date()) -> Date? {

        var resultDate: Date?

        // A recurring event
        if let rrule = self.rrule {
            // If there is a recurring end date: return nil if it's in the past
            if let rruleUntilDate = self.rrule?.until?.date {
                if rruleUntilDate < compareDate {
                    return nil
                }
            }

            // whose calculated end date is in the past
            if let count = rrule.count {
                if count == 1 {
                    if let dtendDate = self.dtend?.date,
                       dtendDate < compareDate {
                        return nil
                    } else {
                        // Risky, maybe, but what event doesn't have a start date?!
                        return self.dtstart?.date
                    }
                }
            }

           // E.g.:
           // b0bh0euetcscugltkbbvqh90un@google.com
           // Repeats 100 times on the third Monday

           let advanceCount = rrule.count ?? Int.max

            // TODO: throw
           let startDate = self.dtstart?.date
           var endDate: Date?

           switch (rrule.frequency) {
           case .secondly:
               endDate = startDate!.firstAfterPeriod(seconds: advanceCount, after: compareDate)
           case .minutely:
               endDate = startDate!.firstAfterPeriod(minutes: advanceCount, after: compareDate)
           case .hourly:
               endDate = startDate!.firstAfterPeriod(hours: advanceCount, after: compareDate)
           case .daily:
               endDate = startDate!.firstAfterPeriod(days: advanceCount, after: compareDate)
           case .weekly:
               endDate = startDate!.firstAfterPeriod(weeks: advanceCount, after: compareDate)
           case .monthly:
               endDate = startDate!.firstAfterPeriod(months: advanceCount, after: compareDate)
           case .yearly:
               endDate = startDate!.firstAfterPeriod(years: advanceCount, after: compareDate)
           }

           if let endDate = endDate {
               if endDate < compareDate {
                   return nil
               } else {

                   return endDate
               }
           }
        }

        // Not a recurring event, whose end time is in the past
        if self.rrule == nil,
           let dtendDate = self.dtend?.date,
           dtendDate < compareDate {

            return nil
        }

        // Non-recurring events with no end time, judge only on their start time.
        // TODO: change to yesterday
        if self.rrule == nil,
           self.dtend == nil,
           let selfDtstart = self.dtstart?.date,
           selfDtstart < compareDate {

            return nil
        }

        // TODO: Obv wrong
        return nil

    }
}
