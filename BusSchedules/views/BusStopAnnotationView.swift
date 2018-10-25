//
//  BusStopView.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 08/09/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import MapKit

class BusStopAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = String(describing: BusStopAnnotationView.self)
        displayPriority = .defaultHigh
        image = #imageLiteral(resourceName: "bus")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
    }
    
}
