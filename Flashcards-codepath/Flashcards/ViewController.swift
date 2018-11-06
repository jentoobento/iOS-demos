//
//  ViewController.swift
//  Flashcards
//
//  Created by Jen on 10/13/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var answer2: String
    var answer3: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel! // answer
    @IBOutlet weak var frontLabel: UILabel! // question
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    // array that will take objects "Flashcard"
    var flashcardArr = [Flashcard]()
    
    // current flashcard index
    var currentCard = 0
    
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
        
        // make labels clickable
        let tapFront = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapFrontLabel))
        frontLabel.isUserInteractionEnabled = true
        frontLabel.addGestureRecognizer(tapFront)
        
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapBackLabel))
        backLabel.isUserInteractionEnabled = true
        backLabel.addGestureRecognizer(tapBack)
        
        updateFlashcard(updatedQuestion: "where in the world is carmen", updatedAnswer: "san diego", updatedAnswer2: "san francisco", updatedAnswer3: "santa monica", addNewCard: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // destination of the segue is the navigation controller
        let navigationController = segue.destination as! UINavigationController
        
        // What to do with the editing page -> should it be populated with data or blank?
        
        
        if segue.identifier != "SettingSegue"{
            // navigation controller only contains a view controller
            let creationController = navigationController.topViewController as! CreationViewController
            creationController.flashcardController = self
            
            
            // separate different segues with different actions
            // user wants to edit, page must be pre-populated with data
            if segue.identifier == "EditSegue" {
                creationController.initialQuestion = frontLabel.text
                creationController.intialAnswer = backLabel.text
                
                creationController.extraAns2 = btnOptionTwo.titleLabel!.text
                creationController.extraAns3 = btnOptionThree.titleLabel!.text
                
                creationController.addNew = false
            }
            
            // user wants to add a new card, do not pre-populate page with data
            if segue.identifier == "PlusSegue" {
                creationController.addNew = true
            }
        }
        
        // user tapped settings, send user to settings page
        if segue.identifier == "SettingSegue" {
            print("segue is settings")
        }
    }
    
    @objc func didTapFrontLabel(_ sender: Any){
        // user gave up, show answer
        self.didTapOptionOne(sender)
        correctLabel.isHidden = true
    }
    
    @objc func didTapBackLabel(_ sender: Any){
        // answer is showing, user wants to see the questions and all the choices again, reset everything
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false
        frontLabel.isHidden = false // show question
        
        correctLabel.isHidden = true
    }
    
    func updateLabels() {
        frontLabel.text = flashcardArr[currentCard].question
        backLabel.text = flashcardArr[currentCard].answer
        
        btnOptionOne.setTitle(flashcardArr[currentCard].answer, for: .normal)
        btnOptionTwo.setTitle(flashcardArr[currentCard].answer2, for: .normal)
        btnOptionThree.setTitle(flashcardArr[currentCard].answer3, for: .normal)
    }
    
    func updateFlashcard(updatedQuestion: String, updatedAnswer: String, updatedAnswer2: String, updatedAnswer3: String, addNewCard: Bool) {
        
        // create the flashcard object
        let flashcard = Flashcard(question: updatedQuestion, answer: updatedAnswer, answer2: updatedAnswer2, answer3: updatedAnswer3)
        
        if addNewCard {
            // add flashcard to the flashcard array
            flashcardArr.append(flashcard)
            
            // update current index
            currentCard = flashcardArr.count - 1
            
            // update the labels
            updateLabels()
            
            // make sure the next and prev buttons are properly disabled
            updateNextAndPrevButtons()
        }else{
            // update the current index with the edited flashcard object
            flashcardArr[currentCard] = flashcard
            
            // update labels
            updateLabels()
        }
        print("total cards: \(flashcardArr.count) all flashcards: \(flashcardArr)")
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
    
    func updateNextAndPrevButtons(){
        // disable the next button if at the last flashcard and vice versa
        btnNext.isEnabled = currentCard == flashcardArr.count - 1 ? false : true
        btnPrev.isEnabled = currentCard == 0 ? false : true
    }
    
    @IBAction func didTapPrev(_ sender: Any) {
        currentCard -= 1
        updateLabels()
        updateNextAndPrevButtons()
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        currentCard += 1
        updateLabels()
        updateNextAndPrevButtons()
    }
}
