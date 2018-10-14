//
//  ViewController.swift
//  Flashcards
//
//  Created by Jen on 10/13/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        card.layer.cornerRadius = 20.0; // add round corners to view
        frontLabel.layer.cornerRadius = 20.0; // add round corners to question
        backLabel.layer.cornerRadius = 20.0; // add round corners to answer
        
        frontLabel.clipsToBounds = true; // show round corners on questions
        backLabel.clipsToBounds = true; // show round corners on answer
        
        card.layer.shadowRadius = 15.0; // add shadow
        card.layer.shadowOpacity = 0.2; // change shadow opacity
        
        btnOptionOne.layer.borderWidth = 3.0;
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.9666306376, green: 0.590148747, blue: 0.7345550656, alpha: 1);
        btnOptionOne.layer.cornerRadius = 20.0;
        btnOptionOne.clipsToBounds = true;
        
        btnOptionTwo.layer.borderWidth = 3.0;
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.9666306376, green: 0.590148747, blue: 0.7345550656, alpha: 1);
        btnOptionTwo.layer.cornerRadius = 20.0;
        btnOptionTwo.clipsToBounds = true;
        
        btnOptionThree.layer.borderWidth = 3.0;
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.9666306376, green: 0.590148747, blue: 0.7345550656, alpha: 1);
        btnOptionThree.layer.cornerRadius = 20.0;
        btnOptionThree.clipsToBounds = true;
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = frontLabel.isHidden ? false : true; // toggle question visibility
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        btnOptionTwo.isHidden = true;
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true;
    }
}
