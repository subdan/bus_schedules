//
//  ViewController.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 30/07/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var copyrightTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = "Данные предоставлены сервисом Яндекс.Расписания"
        let attributedString = NSMutableAttributedString(string: string)
        
        attributedString.addAttribute(.link, value: "https://rasp.yandex.ru", range: NSRange(location: 30, length: 17))
        
        let font = UIFont.systemFont(ofSize: 17)
        
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: string.count))
        
        copyrightTextView.delegate = self
        copyrightTextView.attributedText = attributedString
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

