//
//  RaspService.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 30/07/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import os.log

class RaspService {
    
    static let shared = RaspService()
    
    private init() {}
    
    /// Получает список станций, находящихся в указанном радиусе от указанной точки.
    func stationsNear(lat: Double, lng: Double,
                      completion: @escaping ((StationsNearServiceResult) -> Void)) -> ServiceCall {

        let url = RaspServiceURLBuilder.nearestStations(lat: lat, lng: lng)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(StationsNearServiceResult(isSuccess: false, stationsNear: nil))
                return
            }
            
            guard let jsonData = data else { return }
            
            var isSuccess = true
            
            let decoder = JSONDecoder()
            var result: StationsNear?
            do {
                result = try decoder.decode(StationsNear.self, from: jsonData)
            } catch let error {
                print(error.localizedDescription)
                isSuccess = false
            }
            
            completion(StationsNearServiceResult(isSuccess: isSuccess, stationsNear: result))
        }
        task.resume()
        
        return ServiceCall(task: task)
    }
    
    /// Получает расписание рейсов между станциями
    func scheduleBetweenStations(_ from: Station, _ to: Station,
                                 completion: @escaping ((ScheduleBetweenStationsServiceResult) -> Void)) -> ServiceCall {
        
        let url = RaspServiceURLBuilder.scheduleBetweenStations(from, to)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(ScheduleBetweenStationsServiceResult(isSuccess: false, schedule: nil))
                return
            }
            
            guard let jsonData = data else { return }
            
            var isSuccess = error == nil
            
            let decoder = JSONDecoder()
            var result: ScheduleBetweenStations?
            do {
                result = try decoder.decode(ScheduleBetweenStations.self, from: jsonData)
            } catch let error {
                print(error.localizedDescription)
                isSuccess = false
            }
            
            completion(ScheduleBetweenStationsServiceResult(isSuccess: isSuccess, schedule: result))
        }
        task.resume()
        
        return ServiceCall(task: task)
    }
    
}

class ServiceCall {
    private let task: URLSessionDataTask
    
    init(task: URLSessionDataTask) {
        self.task = task
    }
    
    func cancel() {
        task.cancel()
    }
}

struct StationsNearServiceResult {
    let isSuccess: Bool
    let stationsNear: StationsNear?
}

struct ScheduleBetweenStationsServiceResult {
    let isSuccess: Bool
    let schedule: ScheduleBetweenStations?
}
