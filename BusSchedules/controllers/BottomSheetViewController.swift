//
//  HalfScreenViewController.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 09/09/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import UIKit

class BottomSheetViewController: UIViewController {
    
    var initialPos: CGPoint?
    
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = #colorLiteral(red: 0.1450980392, green: 0.1490196078, blue: 0.368627451, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 12
        view.layer.shadowOpacity = 0.1
        view.layer.masksToBounds = false
        
        view.clipsToBounds = false
        view.isOpaque = false
    }
    
    @IBAction func handleTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        var translation = gesture.translation(in: view.superview)
        
        if gesture.state == .began {
            initialPos = CGPoint(x: view.frame.minX,
                                 y: view.frame.minY)
        } else if gesture.state == .ended {
            if gesture.velocity(in: view.superview).y > 200 {
                dismiss(animated: true, completion: nil)
            } else {
                
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                    self.view.frame = CGRect(x: self.initialPos!.x,
                                             y: self.initialPos!.y,
                                             width: self.view.frame.width,
                                             height: self.view.frame.height)
                    
                }, completion: nil)
            }
            
        } else if gesture.state == .changed {
            
            if initialPos!.y + translation.y < initialPos!.y {
                translation.y *= 0.05
            }
            
            view.frame = CGRect(x: initialPos!.x,
                                y: initialPos!.y + translation.y,
                                width: view.frame.width,
                                height: view.frame.height)
            
        }
    }
    
}
