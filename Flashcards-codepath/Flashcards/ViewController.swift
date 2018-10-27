//
//  ViewController.swift
//  Flashcards
//
//  Created by Jen on 10/13/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel! // answer
    @IBOutlet weak var frontLabel: UILabel! // question
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBAction func makeBtnPretty(_ sender: UIButton) {
        sender.layer.borderWidth = 3.0
        sender.layer.borderColor = #colorLiteral(red: 0.9666306376, green: 0.590148747, blue: 0.7345550656, alpha: 1)
        sender.layer.cornerRadius = 20.0
        sender.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        frontLabel.layer.cornerRadius = 20.0 // add round corners to question
        frontLabel.clipsToBounds = true // show round corners on questions
        
        backLabel.layer.cornerRadius = 20.0 // add round corners to answer
        backLabel.clipsToBounds = true // show round corners on answer
        
        card.layer.cornerRadius = 20.0 // add round corners to view
        card.layer.shadowRadius = 15.0 // add shadow
        card.layer.shadowOpacity = 0.2 // change shadow opacity
        
        self.makeBtnPretty(btnOptionOne)
        self.makeBtnPretty(btnOptionTwo)
        self.makeBtnPretty(btnOptionThree)
        
        correctLabel.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // destination of the segue is the navigation controller
        let navigationController = segue.destination as! UINavigationController
        // navigation controller only contains a view controller
        let creationController = navigationController.topViewController as! CreationViewController
        // set flashcards controller property to self
        creationController.flashcardController = self
        
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden){ // answer is showing
            // i.e. user wants to see the questions and all the choices again
            // reset everything
            btnOptionOne.isHidden = false
            btnOptionTwo.isHidden = false
            btnOptionThree.isHidden = false
            frontLabel.isHidden = false // show question
        } else { // if question is showing
            // i.e. user gave up they want to see answer
            self.didTapOptionOne(sender)
        }
        correctLabel.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        frontLabel.isHidden = true // show answer
        btnOptionOne.isHidden = true // hide all buttons
        btnOptionTwo.isHidden = true
        btnOptionThree.isHidden = true
        correctLabel.isHidden = false
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        btnOptionTwo.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
}
