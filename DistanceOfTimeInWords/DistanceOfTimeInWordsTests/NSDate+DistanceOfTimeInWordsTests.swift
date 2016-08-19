//
//  DistanceOfTimeInWordsTests.swift
//  DistanceOfTimeInWordsTests
//
//  Created by Ben Whiting on 24/02/2016.
//  Copyright © 2016 Plimmerton Consulting Ltd. All rights reserved.
//

import XCTest
import Foundation

@testable import DistanceOfTimeInWords

class DistanceOfTimeInWordsTests: XCTestCase {

    // MARK: Base Date Comparison
    var dateComponents:DateComponents = DateComponents()
    var year:Int = 0
    var month:Int = 0
    var days:Int = 0
    var hours:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0

    override func setUp() {
        super.setUp()
        self.year = 2015 // NOTE: None leap year
        self.month = 1
        self.days = 1
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
        dateComponents = DateComponents()
        dateComponents.calendar = NSCalendar.current
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDistanceOfTimeInWordsWithADateOfNowShouldReturnLessThanAMinute() {
        self.measure {
            // Setup
            let testDate = Date()
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords()

            // Analysis
            XCTAssertEqual(expected, result, "There should be less than a second between the creation of the test date and the string.")
        }
    }

    // MARK: 0 <-> 29 secs -> "less than a minute"
    func testDistanceOfTimeInWordsWithADateOfNowComparedToNowShouldReturnLessThanAMinute() {
        self.measure {
            // Setup
            let testDate = Date()
            let comparedDate = testDate
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "There should be less than a second between the creation of the test date and the string.")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate29SecondsLaterShouldReturnLessThanAMinute() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:29)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate30SecondsLaterShouldNotReturnLessThanAMinute() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:30)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 30 secs <-> 1 min, 29 secs -> "1 minute"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate30SecondsLaterShouldReturnOneMinute() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:30)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Minute29SecondsLaterShouldReturnOneMinute() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:1, seconds:29)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Minute30SecondsLaterShouldNotReturnOneMinute() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:1, seconds:30)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 1min, 30 sec <-> 44 mins 29 secs -> "[2...44] minutes"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Minute30SecondsLaterShouldReturnTwoMinutes() {
        self.measure {
            // Setup
            let expectedMinutes = 2
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:1, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minute29SecondsLaterShouldReturnFortyFourMinutes() {
        self.measure {
            // Setup
            let expectedMinutes = 44
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:expectedMinutes, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minute30SecondsLaterShouldNotReturnFortyFourMinutes() {
        self.measure {
            // Setup
            let expectedMinutes = 44
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:expectedMinutes, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateRandomMinutesBetween2And44With29SecondsLaterShouldCorrectRandomMinutes() {
        self.measure {
            // Setup
            let expectedMinutes = Int(arc4random_uniform(43) + 2)
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:expectedMinutes, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Random minutes: \(expectedMinutes) between 2 and 44 : \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateRandomMinutesBetween2And43With30SecondsLaterShouldCorrectRandomMinutes() {
        self.measure {
            // Setup
            let inputMinutes = Int(arc4random_uniform(42) + 2)
            let expectedMinutes = inputMinutes + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:inputMinutes, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Random minutes: \(inputMinutes) expect it to be rounded to \(expectedMinutes) between 2 and 44 : \(testDate) comparedDate: \(comparedDate)")
        }
    }


    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateBetween2And43MinutesWith30SecondsLaterShouldCorrectRandomMinutes() {
        self.measure {
            // Setup

            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            for minute in 2...44 {
                let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:minute, seconds:29)
                let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(minute)")

                // Test
                let result = testDate.distanceOfTimeInWords(comparedDate)

                // Analysis
                XCTAssertEqual(expected, result, "Should correctly determine the right string for \(testDate) comparedDate: \(comparedDate)")
            }
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minutes30SecondsLaterShouldReturnAboutOneHour() {
        self.measure {
            // Setup
            let expectedMinutes = 44
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours , minutes:expectedMinutes, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 44 mins, 30 secs <-> 89 mins, 29 secs -> "about 1 hour"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minutes29SecondsLaterShouldNotReturnAboutOneHour() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours , minutes:44, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Minutes30SecondsLaterShouldReturnAboutOneHour() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours , minutes:44, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate89Minutes29SecondsLaterShouldReturnAboutOneHour() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:1 , minutes:29, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate89Minutes30SecondsLaterShouldNotReturnAboutOneHour() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:1 , minutes:29, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 89 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs -> "about [2...24] hours"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate89Minutes29SecondsLaterShouldNotReturnAboutTwoHours() {
        self.measure {
            // Setup
            let inputHours = 1
            let expectedHours =  inputHours + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:inputHours , minutes:29, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XHours, comment: String.empty), "\(expectedHours)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate89Minutes30SecondsLaterShouldReturnAboutTwoHours() {
        self.measure {
            // Setup
            let inputHours = 1
            let expectedHours =  inputHours + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:inputHours , minutes:29, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XHours, comment: String.empty), "\(expectedHours)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate23Hours59Minutes29SecondsLaterShouldReturnAboutTwentyFourHours() {
        self.measure {
            // Setup
            let inputHours = 23
            let expectedHours = inputHours + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:inputHours , minutes:59, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XHours, comment: String.empty), "\(expectedHours)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate23Hours59Minutes30SecondsLaterShouldNotReturnAboutTwentyFourHours() {
        self.measure {
            // Setup
            let inputHours = 23
            let expectedHours = inputHours + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:inputHours, minutes:59, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XHours, comment: String.empty), "\(expectedHours)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateBetween2And24HoursAnd29MinutesWith29SecondsLaterShouldReturnCorrectString() {
        self.measure {
            // Setup

            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            for hour in 1...23 {
                let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:hour, minutes:59, seconds:29)
                let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XHours, comment: String.empty), "\(hour + 1)")

                // Test
                let result = testDate.distanceOfTimeInWords(comparedDate)

                // Analysis
                XCTAssertEqual(expected, result, "Should correctly determine the right string for \(testDate) comparedDate: \(comparedDate)")
            }
        }
    }

    // MARK: 23 hours, 59 mins, 30 secs <-> 41 hrs, 59 mins, 29 secs -> "1 day"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate23Hours59Minutes30SecondsLaterShouldNotReturnOneDay() {
        self.measure {
            // Setup
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 29
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneDay, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate23Hours59Minutes30SecondsLaterShouldReturnOneDay() {
        self.measure {
            // Setup
            let inputHours = 23
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.days, hours:inputHours , minutes:59, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneDay, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1day17Hours59Minutes29SecondsLaterShouldReturnOneDay() {
        self.measure {
            // Setup
            let inputDays = self.days + 1
            let inputHours = 17
            let inputMinutes = 59
            let inputSeconds = 29
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneDay, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1day17Hours59Minutes30SecondsLaterShouldNotReturnOneDay() {
        self.measure {
            // Setup
            let inputDays = self.days + 1
            let inputHours = 17
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneDay, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 41 hours, 59 mins, 30 secs <-> 29 days 23 hrs, 59 mins, 29 secs -> "about [2...29] days"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1day17Hours59Minutes30SecondsLaterShouldReturnTwoDays() {
        self.measure {
            // Setup
            let inputDays = self.days + 1
            let inputHours = 17
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XDays, comment: String.empty), "\(inputDays)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateBetween2And29Days23HoursAnd29MinutesWith29SecondsLaterShouldReturnCorrectString() {
        self.measure {
            // Setup

            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            for day in 1...23 {
                let inputDays = self.days + day
                let inputHours = 23
                let inputMinutes = 59
                let inputSeconds = 29
                let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours, minutes:inputMinutes, seconds:inputSeconds)
                let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XDays, comment: String.empty), "\(inputDays)")

                // Test
                let result = testDate.distanceOfTimeInWords(comparedDate)

                // Analysis
                XCTAssertEqual(expected, result, "Should correctly determine the right string for \(testDate) comparedDate: \(comparedDate)")
            }
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate29Days23Hours59Minutes29SecondsLaterShouldReturn29Days() {
        self.measure {
            // Setup
            let inputDays = self.days + 29
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 29
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XDays, comment: String.empty), "\(inputDays)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate29Days23Hours59Minutes30SecondsLaterShouldNotReturn29Days() {
        self.measure {
            // Setup
            let inputDays = self.days + 29
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XDays, comment: String.empty), "\(inputDays)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 29 days, 23 hours, 59 mins, 30 secs <-> 44 days 23 hrs, 59 mins, 29 secs -> "about 1 month"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate29Days23Hours59Minutes29SecondsLaterShouldNotReturnAboutOneMonth() {
        self.measure {
            // Setup
            let inputDays = self.days + 29
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 29
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMonth, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate29Days23Hours59Minutes30SecondsLaterShouldReturnAboutOneMonth() {
        self.measure {
            // Setup
            let inputDays = self.days + 29
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:self.month, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMonth, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Days23Hours59Minutes29SecondsLaterShouldReturnAboutOneMonth() {
        self.measure {
            // Setup
            let inputMonths = self.month + 1
            let inputDays = 14
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 29
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMonth, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADat44Days23Hours59Minutes30SecondsLaterShouldNotReturnAboutOneMonth() {
        self.measure {
            // Setup
            let inputMonths = self.month + 1
            let inputDays = 14
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMonth, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 44 days, 23 hours, 59 mins, 30 secs <-> 59 days 23 hrs, 59 mins, 29 secs -> "about 2 month"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Days23Hours59Minutes29SecondsLaterShouldNotReturnAboutTwoMonths() {
        self.measure {
            // Setup
            let inputMonths = self.month + 1
            let inputDays = 14
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 29
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.TwoMonths, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Days23Hours59Minutes30SecondsLaterShouldReturnAboutTwoMonths() {
        self.measure {
            // Setup
            let inputMonths = self.month + 1
            let inputDays = 14
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.TwoMonths, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate59Days23Hours59Minutes29SecondsLaterShouldReturnAboutTwoMonths() {
        self.measure {
            // Setup
            let inputMonths = self.month + 1
            let inputDays = 29
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 29
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.TwoMonths, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADat44Days23Hours59Minutes30SecondsLaterShouldNotReturnAboutTwoMonths() {
        self.measure {
            // Setup
            let inputMonths = self.month + 1
            let inputDays = 29
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.TwoMonths, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 59 days, 23 hours, 59 mins, 30 secs <-> 1 Year(-1sec) -> "about [2...12] months"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate59day23Hours59Minutes30SecondsLaterShouldReturnAboutTwoMonths() {
        self.measure {
            // Setup
            let inputMonths = self.month + 1
            let inputDays = 29
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 30
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMonths, comment: String.empty), "\(inputMonths)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateBetween59Days23HoursAnd50MintuesAnd30SecondsAnd1YearLessASecondShouldReturnCorrectString() {
        self.measure {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            for month in 2...11 {
                let inputMonths = self.month + month
                var inputDays:Int
                switch inputMonths {
                case 1, 3, 5, 7, 8, 10, 12:
                    inputDays = 31
                case 2:
                    switch(self.year) {
                    case 2016, 2020, 2024:
                        inputDays = 29
                    default:
                        inputDays = 28
                    }
                default:
                    inputDays = 30
                }
                let inputHours = 23
                let inputMinutes = 59
                let inputSeconds = 59
                let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
                let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMonths, comment: String.empty), "\(inputMonths)")

                // Test
                let result = testDate.distanceOfTimeInWords(comparedDate)

                // Analysis
                XCTAssertEqual(expected, result, "Should correctly determine the right string for \(testDate) comparedDate: \(comparedDate)")
            }
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1YearLessASecondLaterShouldReturn12Months() {
        self.measure {
            // Setup
            let inputMonths = self.month + 11
            let inputDays = 30
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 59
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMonths, comment: String.empty), "\(inputMonths)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1YearLaterShouldNotReturn12Months() {
        self.measure {
            // Setup
            let inputYears = self.year + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:self.month, day:self.days, hours:self.hours , minutes:self.minutes, seconds:self.seconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMonths, comment: String.empty), "\(12)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 1 year <-> 1 year, 3 months -> "about 1 year"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1YearLessASecondLaterShouldNotReturnAboutOneYear() {
        self.measure {
            // Setup
            let inputMonths = self.month + 11
            let inputDays = 30
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 59
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(self.year, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneYear, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1YearLaterShouldReturnAboutOneYear() {
        self.measure {
            // Setup
            let inputYears = self.year + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:self.month, day:self.days, hours:self.hours , minutes:self.minutes, seconds:self.seconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneYear, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1YearAnd3MonthsLessASecondLaterShouldReturnAboutOneYear() {
        self.measure {
            // Setup
            let inputYears = 2015
            let inputMonths = 3
            let inputDays = 31
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 59
            let testDate = self.createDate(2014, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneYear, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Year3MonthsLaterShouldNotReturnAboutOneYear() {
        self.measure {
            // Setup
            let inputYears = 2015
            let inputMonths = 4
            let testDate = self.createDate(2014, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:inputMonths, day:self.days, hours:self.hours , minutes:self.minutes, seconds:self.seconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneYear, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: 1 year, 3 months <-> 1 year, 9 months -> "over 1 year"
    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Year3MonthsLessASecondLaterShouldNotReturnOverOneYear() {
        self.measure {
            // Setup
            let inputYears = 2015
            let inputMonths = 3
            let inputDays = 31
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 59
            let testDate = self.createDate(2014, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.Over1Year, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Year4MonthsLaterShouldReturnOverOneYear() {
        self.measure {
            // Setup
            let inputYears = 2015
            let inputMonths = 4
            let testDate = self.createDate(2014, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:inputMonths, day:self.days, hours:self.hours , minutes:self.minutes, seconds:self.seconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.Over1Year, comment: String.empty))
            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1YearAnd9MonthsLessASecondLaterShouldReturnOverOneYear() {
        self.measure {
            // Setup
            let inputYears = 2015
            let inputMonths = 8
            let inputDays = 31
            let inputHours = 23
            let inputMinutes = 59
            let inputSeconds = 59
            let testDate = self.createDate(2014, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:inputMonths, day:inputDays, hours:inputHours , minutes:inputMinutes, seconds:inputSeconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.Over1Year, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Year9MonthsLaterShouldNotReturnOverOneYear() {
        self.measure {
            // Setup
            let inputYears = 2015
            let inputMonths = 10
            let testDate = self.createDate(2014, month:self.month, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let comparedDate = self.createDate(inputYears, month:inputMonths, day:self.days, hours:self.hours, minutes:self.minutes, seconds:self.seconds)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.Over1Year, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    // MARK: Internal Functions
    internal func createDate(_ year:Int, month:Int, day:Int, hours:Int, minutes:Int, seconds:Int) -> Date {
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = seconds
        dateComponents.timeZone = TimeZone(secondsFromGMT:0)

        guard let date = dateComponents.date else {
            XCTAssertTrue(false, "Failed to create date from dateComponents")
            return Date()
        }
        return date
    }
}
