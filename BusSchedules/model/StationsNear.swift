//
//  StationsNearServiceResult.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 08/09/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

struct StationsNear: Decodable {
    let pagination: Pagination
    let stations: [Station]
}

struct Pagination: Decodable {
    let total: Int
    let limit: Int
    let offset: Int
}

struct Station: Decodable {
    let title: String
    let code: String
    let lat: Double?
    let lng: Double?
}
