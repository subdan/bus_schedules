//
//  SegmentTableViewCell.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 13/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class SegmentTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var fromStationLabel: UILabel!
    @IBOutlet weak var toStationLabel: UILabel!
    
    func fill(model: SegmentViewModel) {
        arrivalTimeLabel.text = model.arrivalTimeText
        departureTimeLabel.text = model.departureTimeText
        durationLabel.text = model.durationText
        numberLabel.text = model.numberText
        fromStationLabel.text = model.fromStationText
        toStationLabel.text = model.toStationText
    }

}
