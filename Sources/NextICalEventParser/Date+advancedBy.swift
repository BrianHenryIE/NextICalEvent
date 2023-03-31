//
// Created by Brian Henry on 3/11/23.
//

import Foundation

extension Date {

    func advancedBy(seconds count: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.second = count
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!

        return futureDate
    }

    func advancedBy(minutes count: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.minute = count
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!

        return futureDate
    }

    func advancedBy(hours count: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.hour = count
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!

        return futureDate
    }

    func advancedBy(days count: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = count
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!

        return futureDate
    }

    func advancedBy(weeks count: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.weekOfYear = count
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!

        return futureDate
    }

    func advancedBy(months count: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = count
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!

        return futureDate
    }

    func advancedBy(years count: Int) -> Date {

        var dateComponent = DateComponents()
        dateComponent.year = count
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!

        return futureDate
    }

}
