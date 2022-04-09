//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 10, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemGray5.cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleTextView(_ textview:UITextView) {
        
        
        // Add border on text field
        textview.layer.cornerRadius = 5
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor.systemGray6.cgColor
        

    }
    
    
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.blue
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
}
