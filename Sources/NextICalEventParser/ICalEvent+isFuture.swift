//
// Created by Brian Henry on 3/11/23.
//

import Foundation
import ICalSwift

extension ICalEvent {

    func isFuture(from compareDate: Date = Date()) -> Bool {
        if nextTime(from: compareDate) == nil {
            return false
        }
        return true
    }
}