//
//  BusSchedulesTests.swift
//  BusSchedulesTests
//
//  Created by Daniil Subbotin on 14/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import XCTest
@testable import BusSchedules

class BusSchedulesTests: XCTestCase {

    var model: SegmentViewModel?
    
    override func setUp() {
        let fromStation = Station(title: "Храм Рождества Христова", code: "s9740743", lat: nil, lng: nil)
        let toStation = Station(title: "Ядреево", code: "s9740783", lat: nil, lng: nil)
        let threadValue = ThreadValue(uid: "419_0_f9740702t9744758_44", title: "Мытищи — Москва (м. Медведково)", number: "419", short_title: "Мытищи — Москва (м. Медведково)")
        let segment = Segment(duration: 300, thread: threadValue, departure: "05:43:00", arrival: "05:59:00", from: fromStation, to: toStation)
        model = SegmentViewModel(segment: segment)
    }

    override func tearDown() {
        
    }

    func testArrivalTimeText() {
        XCTAssertEqual(model?.arrivalTimeText, "05:59")
    }
    
    func testDepartureTimeText() {
        XCTAssertEqual(model?.departureTimeText, "05:43")
    }
    
    func testDurationTimeText() {
        XCTAssertEqual(model?.durationText, "5 мин")
    }

}
