//
//  PathElementViewController.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 09/09/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

enum PathElement {
    case start
    case finish
}

class PathElementViewController: BottomSheetViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stationNameLabel: UILabel!
    
    var selectedPathElement: PathElement?
    
    var completionHandler: ((PathElement?) -> Void)?
    
    private var stationName: String?
    
    func setStationName(_ name: String) {
        stationName = name
    }
    
    override func viewDidLoad() {
        stationNameLabel.text = stationName ?? "Маршрут"
    }
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        handlePanGesture(sender)
    }
    
    @IBAction func startAction(_ sender: Any) {
        selectedPathElement = .start
        completionHandler?(selectedPathElement)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishAction(_ sender: Any) {
        selectedPathElement = .finish
        completionHandler?(selectedPathElement)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.layer.cornerRadius = 10
        contentView.layer.cornerRadius = 10
    }
    
}
