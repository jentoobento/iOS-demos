//
//  SettingsViewController.swift
//  Flashcards
//
//  Created by Jen on 10/27/18.
//  Copyright © 2018 Jen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var btnPink: UIButton!
    @IBOutlet weak var btnGrey: UIButton!
    @IBOutlet weak var btnGreen: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapPink(_ sender: Any) {
        print("did tap pink")
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
