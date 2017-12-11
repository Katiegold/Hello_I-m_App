//
//  SkillsVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class SkillsVC: UIViewController {

    @IBOutlet weak var advancedSkillsTextView: UITextView!
    @IBOutlet weak var basicSkillsTextView: UITextView!
    @IBOutlet weak var editSkillsButton: UIButton!
    
    var defaultsData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSkillsTextView.text = defaultsData.string(forKey: "basicSkillsTextView") ?? String()
        advancedSkillsTextView.text = defaultsData.string(forKey: "advancedSkillsTextView") ?? String()
    }

    func saveDefaultsData() {
        defaultsData.set(advancedSkillsTextView.text, forKey: "advancedSkillsTextView")
        defaultsData.set(basicSkillsTextView.text, forKey: "basicSkillsTextView")
    }
    
    
    @IBAction func editSkillsButtonPressed(_ sender: UIButton) {
        if advancedSkillsTextView.isEditable == false {
            advancedSkillsTextView.isEditable = true
            editSkillsButton.setTitle("Done", for: .normal)
            advancedSkillsTextView.becomeFirstResponder()
        } else {
            if advancedSkillsTextView.isEditable == true {
                advancedSkillsTextView.isEditable = false
                editSkillsButton.setTitle("Edit", for: .normal)
            }
        }
        if basicSkillsTextView.isEditable == false {
            basicSkillsTextView.isEditable = true
            editSkillsButton.setTitle("Done", for: .normal)
        } else {
            if basicSkillsTextView.isEditable == true {
                basicSkillsTextView.isEditable = false
                editSkillsButton.setTitle("Edit", for: .normal)
            }
        }
        
        
        saveDefaultsData()
        
    }
    

}
