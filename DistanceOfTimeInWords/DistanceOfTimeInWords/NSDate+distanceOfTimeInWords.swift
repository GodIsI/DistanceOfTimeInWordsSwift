import Foundation

/**
 I like structs and enums to remove duplication of string values.
 */
public struct DistanceOfTimeInWordLocalizationKeys {
    static let LessThan5Seconds = "LessThan5Seconds"
    static let LessThan10Seconds = "LessThan10Seconds"
    static let LessThan20Seconds = "LessThan20Seconds"
    static let LessThanHalfMinute = "LessThanHalfMinute"
    static let LessThanAMinute = "LessThanAMinute"
    static let GreaterThanAMinute = "GreaterThanAMinute"
    static let OneMinute = "OneMinute"
    static let XMinutes = "XMinutes"
    static let OneHour = "OneHour"
    static let XHours = "XHours"
    static let OneDay = "OneDay"
    static let XDays = "XDays"
    static let OneMonth = "OneMonth"
    static let TwoMonths = "TwoMonths"
    static let XMonths = "XMonths"
    static let OneYear = "OneYear"
    static let Over1Year = "Over1Year"
    static let Almost2Years = "Almost2Years"
    static let Over2Years = "Over2Years"
}

extension NSDate {
    struct DivisionConstants {
        static let MinuteAsSeconds:NSTimeInterval = 60
        static let HourAsSeconds:NSTimeInterval = 3600
        static let DayAsSeconds:NSTimeInterval = 86400
        static let MonthsAsSeconds:NSTimeInterval = 2628000
    }
    /**
     Distance Of Time In Words:
     */
    var distanceOfTimeInWords: String {
        return self.distanceOfTimeInWords(NSDate())
    }

    /**
     Distance of Time In Words
     - parameters includedSeconds: Where 'true' and the difference < 1 minute 29 seconds
     it will return accurancy of seconds, where not true or > 1 minute 29 seconds it will use the variable 'distanceOfTimeInWords'
     */

    func distanceOfTimeInWords(compareToDate:NSDate = NSDate()) -> String {
        let difference:NSTimeInterval = self.timeIntervalSinceDate(compareToDate) * -1
        switch (difference) {
        case 0...29:
            return NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)
        case 30...89:
            return NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMinute, comment: String.empty)
        case 90...2669:
            guard let value:Int = Int(round(difference / DivisionConstants.MinuteAsSeconds)) else {
                return String.empty
            }
            return String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(value)")
        case 2670...5369:
            return NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty)
        case 5370...86369:
            let value = self.howManyTimesDoes(DivisionConstants.HourAsSeconds, appearsIn: difference)
            return String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XHours, comment: String.empty), "\(Int(value))")
        case 86370...151169:
            return String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneDay, comment: String.empty))
        case 151170...2591969:
            let value = self.howManyTimesDoes(DivisionConstants.DayAsSeconds, appearsIn: difference)
            return String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XDays, comment: String.empty), "\(Int(value))")
        case 2591970...3887969:
            return String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMonth, comment: String.empty))
        case 3887970...5183969:
            return String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.TwoMonths, comment: String.empty))
        case 5183970...31535999:
            let value = self.howManyTimesDoes(DivisionConstants.MonthsAsSeconds, appearsIn: difference)
            return String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMonths, comment: String.empty), "\(Int(value))")
        default:
            return String.empty
        }
    }

    internal func howManyTimesDoes(division:NSTimeInterval, appearsIn:NSTimeInterval) -> Int {
        var times:Int
        if (appearsIn % DivisionConstants.MinuteAsSeconds) <= 29 {
            guard let value:Int = Int(round(appearsIn / division)) else {
                return -1
            }
            times = value
        } else {
            guard let value:Int = Int(ceil(appearsIn / division)) else {
                return -1
            }
            times = value
        }
        return times
    }

    func distanceOfTimeInWords(includeSeconds:Bool, compareToDate:NSDate = NSDate()) -> String {

        if includeSeconds {
            let difference:NSTimeInterval = self.timeIntervalSinceNow * -1
            switch (difference) {
            case 0...4:
                return String.empty
            case 5...9:
                return String.empty
            case 10...19:
                return String.empty
            case 20...39:
                return String.empty
            case 40...59:
                return String.empty
            case 60...89:
                return String.empty
            default:
                return self.distanceOfTimeInWords(compareToDate)
            }
        }
        return self.distanceOfTimeInWords(compareToDate)
    }
}

/*
0 <-> 29 secs                                                             # => less than a minute
30 secs <-> 1 min, 29 secs                                                # => 1 minute
1 min, 30 secs <-> 44 mins, 29 secs                                       # => [2..44] minutes
44 mins, 30 secs <-> 89 mins, 29 secs                                     # => about 1 hour
89 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                             # => about [2..24] hours
23 hrs, 59 mins, 30 secs <-> 41 hrs, 59 mins, 29 secs                     # => 1 day
41 hrs, 59 mins, 30 secs  <-> 29 days, 23 hrs, 59 mins, 29 secs           # => [2..29] days
29 days, 23 hrs, 59 mins, 30 secs <-> 44 days, 23 hrs, 59 mins, 29 secs   # => about 1 month
44 days, 23 hrs, 59 mins, 30 secs <-> 59 days, 23 hrs, 59 mins, 29 secs   # => about 2 months
59 days, 23 hrs, 59 mins, 30 secs <-> 1 yr minus 1 sec                    # => [2..12] months

1 yr <-> 1 yr, 3 months                                                   # => about 1 year
1 yr, 3 months <-> 1 yr, 9 months                                         # => over 1 year
1 yr, 9 months <-> 2 yr minus 1 sec                                       # => almost 2 years
2 yrs <-> max time or date                                                # => (same rules as 1 yr)

*/


/*
0-4   secs      # => less than 5 seconds
5-9   secs      # => less than 10 seconds
10-19 secs      # => less than 20 seconds
20-39 secs      # => half a minute
40-59 secs      # => less than a minute
60-89 secs      # => 1 minute
*/
