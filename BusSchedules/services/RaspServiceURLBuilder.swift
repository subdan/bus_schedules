//
//  RaspServiceURLBuilder.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 08/09/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

enum RaspServiceConstants: String {
    case API_KEY = "<#API_KEY_HERE#>"
}

class RaspServiceURLBuilder {
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        return dateFormatter
    }()
    
    static func nearestStations(lat: Double, lng: Double, distance: Double = 5) -> URL {
        var urlComponents = URLComponents(string: "https://api.rasp.yandex.net/v3.0/nearest_stations/")!
        
        let apiKey = URLQueryItem(name: "apikey", value: RaspServiceConstants.API_KEY.rawValue)
        let lat = URLQueryItem(name: "lat", value: String(lat))
        let lng = URLQueryItem(name: "lng", value: String(lng))
        let distance = URLQueryItem(name: "distance", value: String(distance))
        let transportTypes = URLQueryItem(name: "transport_types", value: "bus")
        let stationTypes = URLQueryItem(name: "station_types", value: "bus_stop")
        let limit = URLQueryItem(name: "limit", value: "1000")
        
        urlComponents.queryItems = [apiKey, lat, lng, distance, transportTypes, stationTypes, limit]
        
        return urlComponents.url!
    }
    
    static func scheduleBetweenStations(_ from: Station, _ to: Station, date: Date? = nil) -> URL {
        var urlComponents = URLComponents(string: "https://api.rasp.yandex.net/v3.0/search/")!
        
        let apiKey = URLQueryItem(name: "apikey", value: RaspServiceConstants.API_KEY.rawValue)
        let from = URLQueryItem(name: "from", value: from.code)
        let to = URLQueryItem(name: "to", value: to.code)
        let transportTypes = URLQueryItem(name: "transport_types", value: "bus")
        let limit = URLQueryItem(name: "limit", value: "1000")
        
        urlComponents.queryItems = [apiKey, from, to, transportTypes, limit]
        
        if date != nil {
            let dateValue = URLQueryItem(name: "date", value: dateFormatter.string(from: date!))
            urlComponents.queryItems?.append(dateValue)
        }
        
        return urlComponents.url!
    }
    
    static func threadDetails(threadId: String, date: Date? = nil) -> URL {
        var urlComponents = URLComponents(string: "https://api.rasp.yandex.net/v3.0/thread/")!
        
        let apiKey = URLQueryItem(name: "apikey", value: RaspServiceConstants.API_KEY.rawValue)
        let uid = URLQueryItem(name: "uid", value: threadId)
        
        urlComponents.queryItems = [apiKey, uid]
        
        if date != nil {
            let dateValue = URLQueryItem(name: "date", value: dateFormatter.string(from: date!))
            urlComponents.queryItems?.append(dateValue)
        }
        
        return urlComponents.url!
    }
    
}
