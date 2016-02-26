//
//  DistanceOfTimeInWordsTests.swift
//  DistanceOfTimeInWordsTests
//
//  Created by Ben Whiting on 24/02/2016.
//  Copyright © 2016 Plimmerton Consulting Ltd. All rights reserved.
//

import XCTest
@testable import DistanceOfTimeInWords

class DistanceOfTimeInWordsTests: XCTestCase {
    var dateComponents:NSDateComponents = NSDateComponents()
    var year:Int = 0
    var month:Int = 0
    var day:Int = 0
    var hours:Int = 0
    var minutes:Int = 0
    var seconds:Int = 0

    override func setUp() {
        super.setUp()
        year = 2016
        month = 1
        day = 1
        hours = 12
        minutes = 0
        seconds = 0
        dateComponents = NSDateComponents()
        dateComponents.calendar = NSCalendar.currentCalendar()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDistanceOfTimeInWordsWithADateOfNowShouldReturnLessThanAMinute() {
        self.measureBlock {
            // Setup
            let testDate = NSDate()
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords()

            // Analysis
            XCTAssertEqual(expected, result, "There should be less than a second between the creation of the test date and the string.")
        }
    }

    func testDistanceOfTimeInWordsWithADateOfNowComparedToNowShouldReturnLessThanAMinute() {
        self.measureBlock {
            // Setup
            let testDate = NSDate()
            let comparedDate = testDate
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "There should be less than a second between the creation of the test date and the string.")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate29SecondsLaterShouldReturnLessThanAMinute() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:29)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate30SecondsLaterShouldNotReturnLessThanAMinute() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:30)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.LessThanAMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate30SecondsLaterShouldReturnOneMinute() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:30)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Minute29SecondsLaterShouldReturnOneMinute() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:1, seconds:29)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Minute30SecondsLaterShouldNotReturnOneMinute() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:1, seconds:30)
            let expected = NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneMinute, comment: String.empty)

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate1Minute30SecondsLaterShouldReturnTwoMinutes() {
        self.measureBlock {
            // Setup
            let expectedMinutes = 2
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:1, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minute29SecondsLaterShouldReturnFortyFourMinutes() {
        self.measureBlock {
            // Setup
            let expectedMinutes = 44
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:expectedMinutes, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minute30SecondsLaterShouldNotReturnFortyFourMinutes() {
        self.measureBlock {
            // Setup
            let expectedMinutes = 44
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:expectedMinutes, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateRandomMinutesBetween2And44With29SecondsLaterShouldCorrectRandomMinutes() {
        self.measureBlock {
            // Setup
            let expectedMinutes = Int(arc4random_uniform(44) + 1)
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:expectedMinutes, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Random minutes: \(expectedMinutes) between 2 and 44 : \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADateRandomMinutesBetween2And43With30SecondsLaterShouldCorrectRandomMinutes() {
        self.measureBlock {
            // Setup
            let inputMinutes = Int(arc4random_uniform(43) + 1)
            let expectedMinutes = inputMinutes + 1
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:inputMinutes, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.XMinutes, comment: String.empty), "\(expectedMinutes)")

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Random minutes: \(inputMinutes) expect it to be rounded to \(expectedMinutes) between 2 and 44 : \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minutes30SecondsLaterShouldReturnAboutOneHour() {
        self.measureBlock {
            // Setup
            let expectedMinutes = 44
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours , minutes:expectedMinutes, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate44Minutes29SecondsLaterShouldNotReturnAboutOneHour() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours , minutes:44, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate89Minutes29SecondsLaterShouldReturnAboutOneHour() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:13 , minutes:29, seconds:29)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertEqual(expected, result, "Bottom end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    func testDistanceOfTimeInWordsWithAControlledDateComparedToADate89Minutes30SecondsLaterShouldNotReturnAboutOneHour() {
        self.measureBlock {
            // Setup
            let testDate = self.createDate(self.year, month:self.month, day:self.day, hours:self.hours, minutes:self.minutes, seconds:0)
            let comparedDate = self.createDate(self.year, month:self.month, day:self.day, hours:1 , minutes:29, seconds:30)
            let expected = String.localizedStringWithFormat(NSLocalizedString(DistanceOfTimeInWordLocalizationKeys.OneHour, comment: String.empty))

            // Test
            let result = testDate.distanceOfTimeInWords(comparedDate)

            // Analysis
            XCTAssertNotEqual(expected, result, "Top end boundry test testDate: \(testDate) comparedDate: \(comparedDate)")
        }
    }

    internal func createDate(year:Int, month:Int, day:Int, hours:Int, minutes:Int, seconds:Int) -> NSDate {
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = seconds
        guard let date = dateComponents.date else {
            XCTAssertTrue(false, "Failed to create date from dateComponents")
            return NSDate()
        }
        return date
    }
}
