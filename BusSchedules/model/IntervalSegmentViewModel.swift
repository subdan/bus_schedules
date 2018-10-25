//
//  IntervalSegmentViewModel.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 14/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

class IntevalSegmentViewModel {
    let durationText: String
    let densityText: String
    let numberText: String
    let fromToStationText: String
    
    init(segment: IntervalSegment) {
        durationText = "\(Int(segment.duration / 60)) мин"
        numberText = segment.thread.number
        fromToStationText = segment.thread.title
        densityText = segment.thread.interval.density
    }
}
