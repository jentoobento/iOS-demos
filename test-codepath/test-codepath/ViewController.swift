//
//  ViewController.swift
//  test-codepath
//
//  Created by Jen on 9/20/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField! // access the text field so we can grab user input
    @IBOutlet weak var textLabel: UILabel! // adding the label here so we can access it
    
    var bgColor: UIColor! // make empty variable for bg color
    
    override func viewDidLoad() { // this function is called when screen first loads
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // remember the bg color
        bgColor = view.backgroundColor
    }
    
    
    @IBAction func didTapTextButton(_ sender: Any) {
        
        if(textField.text != ""){
            textLabel.text = textField.text // use whatever user entered
            textField.text = "" // make the text go away
            view.endEditing(true) // make the keyboard go away after
            
        }else{
            
        if(textLabel.text == "Buh bye"){
            textLabel.text = "Hello"
        }else{
            textLabel.text = "Buh bye"
        }
        }
    }
    
    @IBAction func didTapViewButton(_ sender: Any) {
        // will run when bg button is tapped
        
        if(view.backgroundColor == bgColor){ // if purple change to green
            print("background color is purple")
            // minty green
            // c7febb
            view.backgroundColor = UIColor.init(red: 199/255, green: 254/255, blue: 187/255, alpha: 1)
        }else if(view.backgroundColor == UIColor.init(red: 199/255, green: 254/255, blue: 187/255, alpha: 1)){ // if green change to pink
            print("background color is pink")
            // peach
            // fcd7c1
            view.backgroundColor = UIColor.init(red: 252/255, green: 215/255, blue: 193/255, alpha: 1)
        }else{ // if pink change to green
            print("background color is green")
            view.backgroundColor = UIColor.init(red: 199/255, green: 254/255, blue: 187/255, alpha: 1)
        }
        
        
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        // this will run when button is pressed
        print("you tapped the button")
        
        textLabel.textColor = UIColor.orange
    }
    

    @IBAction func onResetGesture(_ sender: Any) { // this tapping gesture is basically same as the previous 
        // lots of other gestures available
        textLabel.text = "Hello"
        view.backgroundColor = bgColor
        textLabel.textColor = UIColor.black
    }
}

