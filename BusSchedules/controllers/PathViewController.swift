//
//  PathViewController.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 07/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

protocol PathViewControllerDelegate: class {
    func inversed()
}

class PathViewController: UIViewController {
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    var appState: AppState?
    
    weak var delegate: PathViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        update()
        
        view.layer.shadowPath =
            CGPath(rect: view.bounds, transform: nil)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 15
        view.layer.masksToBounds = false
        
        super.viewWillAppear(animated)
    }
    
    @IBAction func inverse(_ sender: Any) {
        appState?.inverse()
        delegate?.inversed()
        update()
    }
    
    func update() {
        if let station = appState?.fromStation {
            fromLabel.text = station.title
        }
        
        if let station = appState?.toStation {
            toLabel.text = station.title
        }
    }
}
