//
//  AppState.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 13/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

class AppState {
    var fromStation: Station?
    var toStation: Station?
    
    func inverse() {
        guard fromStation != nil && toStation != nil else {
            return
        }
        let temp = fromStation
        fromStation = toStation
        toStation = temp
    }
}
