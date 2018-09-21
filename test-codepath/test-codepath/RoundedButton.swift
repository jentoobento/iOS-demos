//
//  RoundedButton.swift
//  test-codepath
//
//  Created by Jen on 9/20/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    /*
     
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderWidth = 1/UIScreen.main.nativeScale // get the border line to always be 1 pixel no matter the screen size
        layer.borderColor = UIColor.purple.cgColor // change the border color
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // adds padding
        // layer.cornerRadius = frame.height/2 // make rounded corners, this line must be in layout subviews
    }
 
 */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
    }
}
