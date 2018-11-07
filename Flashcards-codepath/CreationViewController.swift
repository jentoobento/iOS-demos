//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Jen on 10/27/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    // give access to flashcards controller
    var flashcardController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraAnswer2: UITextField!
    @IBOutlet weak var extraAnswer3: UITextField!
    
    var initialQuestion: String?
    var intialAnswer: String?
    var extraAns2: String?
    var extraAns3: String?
    
    var addNew: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        questionTextField.text = initialQuestion
        answerTextField.text = intialAnswer
        extraAnswer2.text = extraAns2
        extraAnswer3.text = extraAns3
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let newQuestion = questionTextField.text
        let newAnswer = answerTextField.text
        let newAnswer2 = extraAnswer2.text
        let newAnswer3 = extraAnswer3.text
        
        let alert = UIAlertController(title: "Missing Text", message: "You must have a question, answer, and 2 false answers.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        // validation
        if(newQuestion == nil || newAnswer == nil || newQuestion!.isEmpty || newAnswer!.isEmpty || newAnswer2 == nil || newAnswer2!.isEmpty || newAnswer3 == nil ||  newAnswer3!.isEmpty){
            present(alert, animated: true)
        }else{
            
//            print("question: \(newQuestion) answer: \(newAnswer) answer2: \(newAnswer2) answer3: \(newAnswer3)")
            
            // call the update flashcard function from the main view controller
            flashcardController.updateFlashcard(updatedQuestion: newQuestion!, updatedAnswer: newAnswer!, updatedAnswer2: newAnswer2!, updatedAnswer3: newAnswer3!, addNewCard: addNew!)
            dismiss(animated: true)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
