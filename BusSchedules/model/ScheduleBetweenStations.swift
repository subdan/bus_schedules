//
//  ScheduleBetweenStations.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 07/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

struct ScheduleBetweenStations: Decodable {
    let pagination: Pagination
    let interval_segments: [IntervalSegment]
    let segments: [Segment]
}

struct Segment: Decodable {
    let duration: Int
    let thread: ThreadValue
    let departure: String
    let arrival: String
    let from: Station
    let to: Station
}

struct IntervalSegment: Decodable {
    let duration: Int
    let thread: IntervalThreadValue
}

struct ThreadValue: Decodable {
    let uid: String
    let title: String
    let number: String
    let short_title: String
}

struct IntervalThreadValue: Decodable {
    let uid: String
    let title: String
    let interval: Interval
    let number: String
    let short_title: String
}

struct Interval: Decodable {
    let density: String
    let end_time: String
    let begin_time: String
}
