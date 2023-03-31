//
// Created by Brian Henry on 3/11/23.
//

import Foundation

extension Date {

    func firstAfterPeriod(seconds count: Int, after compareDate: Date = Date()) -> Date? {

        var futureDate = compareDate
        var increment = 0

        while ( futureDate <= compareDate && increment < count ) {
            futureDate = self.advancedBy(seconds: increment)
            increment += 1
        }

        return futureDate > compareDate ? futureDate : nil
    }

    func firstAfterPeriod(minutes count: Int, after compareDate: Date = Date()) -> Date? {

        var futureDate = compareDate
        var increment = 0

        while ( futureDate <= compareDate && increment < count ) {
            futureDate = self.advancedBy(minutes: increment)
            increment += 1
        }

        return futureDate > compareDate ? futureDate : nil
    }

    func firstAfterPeriod(hours count: Int, after compareDate: Date = Date()) -> Date? {

        var futureDate = compareDate
        var increment = 0

        while ( futureDate <= compareDate &&  increment < count  ) {
            futureDate = self.advancedBy(hours: increment)
            increment += 1
        }

        return futureDate > compareDate ? futureDate : nil
    }

    func firstAfterPeriod(days count: Int, after compareDate: Date = Date()) -> Date? {

        var futureDate = compareDate
        var increment = 0

        while ( futureDate <= compareDate && increment < count ) {
            futureDate = self.advancedBy(days: increment)
            increment += 1
        }

        return futureDate > compareDate ? futureDate : nil
    }

    func firstAfterPeriod(weeks count: Int, after compareDate: Date = Date()) -> Date? {

        var futureDate = compareDate
        var increment = 0

        while ( futureDate <= compareDate && increment < count ) {
            futureDate = self.advancedBy(weeks: increment)
            increment += 1
        }

        return futureDate > compareDate ? futureDate : nil
    }

    func firstAfterPeriod(months count: Int, after compareDate: Date = Date()) -> Date? {

        var futureDate = compareDate
        var increment = 0

        while ( futureDate <= compareDate && increment < count ) {
            futureDate = self.advancedBy(months: increment)
            increment += 1
        }

        return futureDate > compareDate ? futureDate : nil
    }

    func firstAfterPeriod(years count: Int, after compareDate: Date = Date()) -> Date? {

        var futureDate = compareDate
        var increment = 0

        while ( futureDate <= compareDate && increment < count ) {
            futureDate = self.advancedBy(years: increment)
            increment += 1
        }

        return futureDate > compareDate ? futureDate : nil
    }
}