//
//  BusStopClusterView.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 08/09/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import MapKit

class BusStopClusterView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        displayPriority = .defaultHigh
        collisionMode = .circle
        
        if let cluster = annotation as? MKClusterAnnotation {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40.0, height: 40.0))
            let count = cluster.memberAnnotations.count
            image = renderer.image { _ in
                
                UIColor(red: 60/255, green: 108/255, blue: 150/255, alpha: 1).setFill()
                UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)).fill()
                let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
                let text = "\(count)"
                let size = text.size(withAttributes: attributes)
                let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
                text.draw(in: rect, withAttributes: attributes)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) not implemented.")
    }
   
}
