//
//  SettingsViewController.swift
//  Flashcards
//
//  Created by Jen on 10/27/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // give access to flashcard controller
    var flashcardController: ViewController!
    
    // buttons to change background color
    @IBOutlet weak var btnPink: UIButton!
    @IBOutlet weak var btnBlue: UIButton!
    @IBOutlet weak var btnGreen: UIButton!
    @IBOutlet weak var btnPurple: UIButton!
    @IBOutlet weak var btnWhite: UIButton!
    
    // buttons to change text color
    @IBOutlet weak var btnBlack: UIButton!
    @IBOutlet weak var btnGray: UIButton!
    
    @IBOutlet weak var testLabel: UILabel!
    
    var cardColorBtnArr = [UIButton]()
    var currentColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    var txtColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    var didChangeTxtColor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBlack.layer.borderWidth = 2.0
        btnBlack.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnGray.layer.borderWidth = 2.0
        btnGray.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        cardColorBtnArr.append(btnPink)
        cardColorBtnArr.append(btnBlue)
        cardColorBtnArr.append(btnGreen)
        cardColorBtnArr.append(btnPurple)
        cardColorBtnArr.append(btnWhite)
        
        currentColor = flashcardController.frontLabel.backgroundColor!
        txtColor = flashcardController.frontLabel.textColor!
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapDone(_ sender: Any) {
        flashcardController.frontLabel.backgroundColor = currentColor
        flashcardController.backLabel.backgroundColor = currentColor
        flashcardController.btnOptionOne.layer.borderColor = currentColor.cgColor
        flashcardController.btnOptionTwo.layer.borderColor = currentColor.cgColor
        flashcardController.btnOptionThree.layer.borderColor = currentColor.cgColor
        flashcardController.answerDescription?.textColor = txtColor
        
        switch currentColor {
        case #colorLiteral(red: 0.968627451, green: 0.8117647059, blue: 0.9607843137, alpha: 1) :
            setButtonColors(color: #colorLiteral(red: 0.9666306376, green: 0.590148747, blue: 0.7345550656, alpha: 1))
        case #colorLiteral(red: 0.7333333333, green: 0.937254902, blue: 0.9058823529, alpha: 1) :
            setButtonColors(color: #colorLiteral(red: 0.5837262869, green: 0.746342957, blue: 0.7251857519, alpha: 1))
        case #colorLiteral(red: 0.7764705882, green: 0.9882352941, blue: 0.7333333333, alpha: 1) :
            setButtonColors(color: #colorLiteral(red: 0.6327180266, green: 0.8095536828, blue: 0.6074897647, alpha: 1))
        case #colorLiteral(red: 0.8863797784, green: 0.7248074412, blue: 1, alpha: 1) :
            setButtonColors(color: #colorLiteral(red: 0.7609060407, green: 0.6258032918, blue: 0.8636335731, alpha: 1))
        case #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1) :
            setButtonColors(color: #colorLiteral(red: 0.7873575091, green: 0.7859320045, blue: 0.8093724847, alpha: 1))
        default: break
        }
        
        if didChangeTxtColor {
            flashcardController.frontLabel.textColor = txtColor
            flashcardController.backLabel.textColor = txtColor
        }
        dismiss(animated: true)
    }
    
    func setButtonColors(color: UIColor){
        flashcardController.btnOptionOne.setTitleColor(color, for: .normal)
        flashcardController.btnOptionTwo.setTitleColor(color, for: .normal)
        flashcardController.btnOptionThree.setTitleColor(color, for: .normal)
    }
    
    @IBAction func didTapPink(_ sender: Any) {
        setCurrentColor(color: #colorLiteral(red: 0.968627451, green: 0.8117647059, blue: 0.9607843137, alpha: 1))
    }
    
    @IBAction func didTapBlue(_ sender: Any) {
        setCurrentColor(color: #colorLiteral(red: 0.7333333333, green: 0.937254902, blue: 0.9058823529, alpha: 1))
    }
    
    @IBAction func didTapGreen(_ sender: Any) {
        setCurrentColor(color: #colorLiteral(red: 0.7764705882, green: 0.9882352941, blue: 0.7333333333, alpha: 1))
    }
    
    @IBAction func didTapPurple(_ sender: Any) {
        setCurrentColor(color: #colorLiteral(red: 0.8863797784, green: 0.7248074412, blue: 1, alpha: 1))
    }
    
    @IBAction func didTapWhite(_ sender: Any) {
        setCurrentColor(color: #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1))
    }
    
    func setCurrentColor(color: UIColor){
        currentColor = color
        testLabel.backgroundColor = currentColor
    }
    
    @IBAction func didTapBlack(_ sender: Any) {
        changeTestTextColor(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }
    
    @IBAction func didTapGray(_ sender: Any) {
        changeTestTextColor(color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    }
    
    func changeTestTextColor(color: UIColor){
        didChangeTxtColor = true
        txtColor = color
        testLabel.textColor = txtColor
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
