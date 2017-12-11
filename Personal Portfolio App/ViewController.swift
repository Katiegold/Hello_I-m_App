//
//  ViewController.swift
//  Personal Portfolio App
//
//  Created by Katie on 11/28/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    var defaultsData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = defaultsData.string(forKey: "nameTextField") ?? String()
    }
    
    func saveDefaultsData() {
    defaultsData.set(nameTextField.text, forKey: "nameTextField")
    }
    @IBAction func nameTextFieldDoneButtonPressed(_ sender: UITextField) {
        if nameTextField.isEnabled == false {
            nameTextField.isEnabled = true
            nameTextField.becomeFirstResponder()
        } else {
            if nameTextField.isEnabled == true {
                nameTextField.isEnabled = false
            }
            saveDefaultsData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AboutSegue"?:
            _ = segue.destination as! AboutVC
        case "EducationSegue"?:
            _ = segue.destination as! EducationVC
        case "SkillsSegue"?:
            _ = segue.destination as! SkillsVC
        case "ContactSegue"?:
            _ = segue.destination as! ContactVC
        case "ExperienceSegue"?:
            _ = segue.destination as! ExperienceVC
        case "ActivitySegue"?:
            _ = segue.destination as! ActivityVC
        case "GraphicDesignSegue"?:
            _ = segue.destination as! GraphicDesignVC
        case "BlogsSegue"?:
            _ = segue.destination as! BlogsVC
        default: print("erorr with segues")
            
    }


}
    
    
    

}

