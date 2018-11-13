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
    var description: String? = nil
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UILabel! // answer
    @IBOutlet weak var frontLabel: UILabel! // question
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var answerDescription: UITextView?
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    // array that will take objects "Flashcard"
    var flashcardArr = [Flashcard]()
    
    // current flashcard index
    var currentCard = 0
    
    func makeBtnPretty(btn: UIButton) {
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = #colorLiteral(red: 0.968627451, green: 0.8117647059, blue: 0.9607843137, alpha: 1)
        btn.layer.cornerRadius = 20.0
        btn.clipsToBounds = true
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
        
        self.makeBtnPretty(btn: btnOptionOne)
        self.makeBtnPretty(btn: btnOptionTwo)
        self.makeBtnPretty(btn: btnOptionThree)
        
        correctLabel.isHidden = true
        
        // make labels clickable
        let tapFront = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapFrontLabel))
        frontLabel.isUserInteractionEnabled = true
        frontLabel.addGestureRecognizer(tapFront)
        
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapBackLabel))
        backLabel.isUserInteractionEnabled = true
        backLabel.addGestureRecognizer(tapBack)
        
        // read saved flashcards from disk if any
        readSavedFlashcards()
        
        if flashcardArr.count == 0 {
            updateFlashcard(updatedQuestion: "where in the world is carmen", updatedAnswer: "san diego", updatedAnswer2: "san francisco", updatedAnswer3: "santa monica", answerDescription: nil, addNewCard: true)
        }else{
            updateLabels()
            updateNextAndPrevButtons()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // destination of the segue is the navigation controller
        let navigationController = segue.destination as! UINavigationController
        
        // What to do with the editing page -> should it be populated with data or blank?
        if segue.identifier != "SettingSegue" {
            // navigation controller only contains a view controller
            let creationController = navigationController.topViewController as! CreationViewController
            creationController.flashcardController = self
            
            // separate different segues with different actions
            // user wants to edit, page must be pre-populated with data
            if segue.identifier == "EditSegue" {
                creationController.initialQuestion = frontLabel.text
                creationController.intialAnswer = backLabel.text
                
                // make sure correct answer and false ones populate correct text fields in the editing screen
                if btnOptionOne.titleLabel!.text == backLabel.text {
                    creationController.extraAns2 = btnOptionTwo.titleLabel!.text
                    creationController.extraAns3 = btnOptionThree.titleLabel!.text
                } else if btnOptionTwo.titleLabel!.text == backLabel.text {
                    creationController.extraAns2 = btnOptionOne.titleLabel!.text
                    creationController.extraAns3 = btnOptionThree.titleLabel!.text
                } else {
                    creationController.extraAns2 = btnOptionOne.titleLabel!.text
                    creationController.extraAns3 = btnOptionTwo.titleLabel!.text
                }
                creationController.initialDesc = answerDescription?.text
            }
            // determine whether user is editing or adding a card
            creationController.addNew = segue.identifier == "PlusSegue" ? true : false
        }
        
        // user tapped settings, send user to settings page
        if segue.identifier == "SettingSegue" {
            let settingController = navigationController.topViewController as! SettingsViewController
            settingController.flashcardController = self
        }
    }
    
    @objc func didTapFrontLabel(){
        // user gave up, show answer
        showAnswer(showIsCorrectLabel: false)
        correctLabel.isHidden = true
    }
    
    @objc func didTapBackLabel(){
        // answer is showing, user wants to see the questions and all the choices again, reset everything
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false
        frontLabel.isHidden = false // show question
        answerDescription?.isHidden = true
        answerDescription?.isEditable = false
        correctLabel.isHidden = true
    }
    
    func updateLabels() {
        frontLabel.text = flashcardArr[currentCard].question
        backLabel.text = flashcardArr[currentCard].answer
        // if answerDescription has a value, use it, else use nil
        answerDescription?.text = flashcardArr[currentCard].description
        
        var answerArr = [String]()
        answerArr.append(flashcardArr[currentCard].answer)
        answerArr.append(flashcardArr[currentCard].answer2)
        answerArr.append(flashcardArr[currentCard].answer3)
        answerArr.shuffle()
        
        btnOptionOne.setTitle(answerArr[0], for: .normal)
        btnOptionTwo.setTitle(answerArr[1], for: .normal)
        btnOptionThree.setTitle(answerArr[2], for: .normal)
        
        // make sure the next and prev buttons are properly disabled
        updateNextAndPrevButtons()
        
        // reset everything
        didTapBackLabel()
    }
    
    func updateFlashcard(updatedQuestion: String, updatedAnswer: String, updatedAnswer2: String, updatedAnswer3: String, answerDescription: String?, addNewCard: Bool) {
        
        // create the flashcard object
        let flashcard = Flashcard(question: updatedQuestion, answer: updatedAnswer, answer2: updatedAnswer2, answer3: updatedAnswer3, description: answerDescription)
        
        if addNewCard {
            // add flashcard to the flashcard array
            flashcardArr.append(flashcard)
            
            // update current index
            currentCard = flashcardArr.count - 1
        }else{
            // update the current index with the edited flashcard object
            flashcardArr[currentCard] = flashcard
        }
        
        // update labels
        updateLabels()
        
        // save changes
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOptionOne() {
        determineCorrectAnswer(btn: btnOptionOne)
    }
    
    @IBAction func didTapOptionTwo() {
        determineCorrectAnswer(btn: btnOptionTwo)
    }
    
    @IBAction func didTapOptionThree() {
        determineCorrectAnswer(btn: btnOptionThree)
    }
    
    func determineCorrectAnswer(btn: UIButton){
        if btn.currentTitle == backLabel.text {
            showAnswer(showIsCorrectLabel: true)
        }else{
            btn.isHidden = true
        }
    }
    
    func showAnswer(showIsCorrectLabel: Bool){
        frontLabel.isHidden = true // show answer
        btnOptionOne.isHidden = true // hide all buttons
        btnOptionTwo.isHidden = true
        btnOptionThree.isHidden = true
        answerDescription?.isHidden = false
        correctLabel.isHidden = showIsCorrectLabel ? false : true
    }
    
    func updateNextAndPrevButtons(){
        // disable the next button if at the last flashcard and vice versa
        btnNext.isEnabled = currentCard == flashcardArr.count - 1 ? false : true
        btnPrev.isEnabled = currentCard == 0 ? false : true
    }
    
    @IBAction func didTapPrev() {
        currentCard -= 1
        updateLabels() // reset everything
    }
    
    @IBAction func didTapNext() {
        currentCard += 1
        updateLabels()
    }
    
    @IBAction func swipeAction(_ gestureRecognizer: UISwipeGestureRecognizer) {
        print("swiped! \(gestureRecognizer.direction)")
        if gestureRecognizer.direction.rawValue == 1 && currentCard != 0 {
            print("swiped right")
            didTapPrev()
        }
        // if gestureRecognizer.direction.rawValue == 2 && currentCard != flashcardArr.count - 1 { print("swiped left") }
    }
    
    func saveAllFlashcardsToDisk() {
        // save array to disk using user defaults
        // "set" means array and it must have a unique string key
        // however user defaults only reads array of dictionaries, must convert to dictionary
        let dictionaryArr = flashcardArr.map { (card) -> [String: String] in
            return ["question": card.question, "answer":card.answer, "answer2":card.answer2, "answer3":card.answer3, "description": card.description ?? ""]
        }
        print("dictionary: \(dictionaryArr)")
        UserDefaults.standard.set(dictionaryArr, forKey: "FlashcardKey")
    }
    
    func readSavedFlashcards(){
        // read dictionary array from disk if any, use dictionary's unique key we gave earlier
        // "if let" will store a value in the variable if it exists
        if let dictionaryArr = UserDefaults.standard.array(forKey: "FlashcardKey") as? [[String: String]]{
            // convert the dictionary back to an array
            let savedCards = dictionaryArr.map{ dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, answer2: dictionary["answer2"]!, answer3: dictionary["answer3"]!, description: dictionary["description"])
            }
            // add all the cards to the array
            flashcardArr.append(contentsOf: savedCards)
        }
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        // confirm deletion
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        // "destructive" makes the GUI look red and bold
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentCard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentCard(){
        // do not remove the last card in the deck
        if flashcardArr.count == 1 {
            let alert = UIAlertController(title: "Cannot Delete", message: "You can't delete this card because the deck would be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }else{
            // proceed with deletion
            // removes item at current index, all items behind it get pushed forward
            flashcardArr.remove(at: currentCard)
            
            // move current index if deleting last card
            currentCard = currentCard > flashcardArr.count - 1 ? flashcardArr.count - 1 : currentCard
            
            updateLabels()
            
            // save changes
            saveAllFlashcardsToDisk()
        }
    }
}
