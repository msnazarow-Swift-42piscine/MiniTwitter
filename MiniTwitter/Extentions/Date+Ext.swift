//
//  Date+Extensions.swift
//

import Foundation

extension Date {
    static var MondeyOfThisWeek: Date? {
        let calendar = Calendar(identifier: .iso8601)
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    var weekDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }

    var hoursPast: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }

    var minutePast: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "m"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }

    var secondsPast: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "s"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
    var dateSlashString: String {
        DateFormatter.YYYYMMdd.string(from: self)
    }

    func byAddingDay(_ day: Int) -> Date {
        var components = DateComponents()
        components.day = day
        return Calendar.current.date(byAdding: components, to: self)!
    }

//    var compactForm: String {
//        if self.isToday {
//            switch -timeIntervalSinceNow {
//            case <60:
//                secondsPast
//            }
//
//        }
//        let hourString = hour < 10 ? "0\(hour)" : "\(hour)"
//        let minuteString = minute < 10 ? "0\(minute)" : "\(minute)"
//        return "\(hourString):\(minuteString)"
//    }
}
