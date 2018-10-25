//
//  IntervalSegmentTableViewCell.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 13/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class IntervalSegmentTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var fromToStationLabel: UILabel!
    
    func fill(model: IntevalSegmentViewModel) {
        fromToStationLabel.text = model.fromToStationText
        durationLabel.text = model.durationText
        numberLabel.text = model.numberText
        timeLabel.text = model.densityText
    }

}
