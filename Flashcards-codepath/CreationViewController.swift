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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        questionTextField.text = initialQuestion
        answerTextField.text = intialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let answer2 = extraAnswer2.text
        let answer3 = extraAnswer3.text
        
        let alert = UIAlertController(title: "Missing Text", message: "You must have a question and answers", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        // validation
        if(questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty){
            present(alert, animated: true)
        }else{
            flashcardController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswer2: answer2!, extraAnswer3: answer3!)
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
