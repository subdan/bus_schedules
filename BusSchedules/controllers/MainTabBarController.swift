//
//  MainTabBarController.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 13/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let appState = AppState()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mapViewController = viewControllers?[0] as! MapViewController
        mapViewController.appState = appState
        
        let toMoscowViewController = (viewControllers?[1] as! UINavigationController).viewControllers[0] as! ScheduleViewController
        toMoscowViewController.appState = appState
    }
    
}
