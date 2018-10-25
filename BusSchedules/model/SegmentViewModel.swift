//
//  SegmentViewModel.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 14/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

public class SegmentViewModel {
    
    let arrivalTimeText: String
    let departureTimeText: String
    let durationText: String
    let numberText: String
    let fromStationText: String
    let toStationText: String
    
    init(segment: Segment) {
        var time = segment.arrival
        var from = time.startIndex
        var to = time.index(time.endIndex, offsetBy: -4)
        time = String(time[from...to])
        arrivalTimeText = time
        
        time = segment.departure
        from = time.startIndex
        to = time.index(time.endIndex, offsetBy: -4)
        time = String(time[from...to])
        departureTimeText = time
        
        durationText = "\(Int(segment.duration / 60)) мин"
        
        numberText = segment.thread.number
        fromStationText = segment.from.title
        toStationText = segment.to.title
    }
}
