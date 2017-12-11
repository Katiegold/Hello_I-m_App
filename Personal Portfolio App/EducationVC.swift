//
//  EducationVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class EducationVC: UIViewController {
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var editEducationButton: UIButton!
    var defaultsData = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolNameTextField.text = defaultsData.string(forKey: "schoolNameTextField") ?? String()
        cityTextField.text = defaultsData.string(forKey: "cityTextField") ?? String()
        descriptionTextView.text = defaultsData.string(forKey: "descriptionTextView") ?? String()

    }

    func saveDefaultsData() {
        defaultsData.set(schoolNameTextField.text, forKey: "schoolNameTextField")
        defaultsData.set(cityTextField.text, forKey: "cityTextField")
        defaultsData.set(descriptionTextView.text, forKey: "descriptionTextView")

    }
    
    @IBAction func editEducationButtonPressed(_ sender: UIButton) {
        if descriptionTextView.isEditable == false {
            descriptionTextView.isEditable = true
            editEducationButton.setTitle("Done", for: .normal)
        } else {
            if descriptionTextView.isEditable == true {
                descriptionTextView.isEditable = false
                editEducationButton.setTitle("Edit", for: .normal)
            }
        }
        if schoolNameTextField.isEnabled == false {
            schoolNameTextField.isEnabled = true
            editEducationButton.setTitle("Done", for: .normal)
            schoolNameTextField.becomeFirstResponder()
        } else {
            if schoolNameTextField.isEnabled == true {
                schoolNameTextField.isEnabled = false
                editEducationButton.setTitle("Edit", for: .normal)
            }

        }
        if cityTextField.isEnabled == false {
            cityTextField.isEnabled = true
            editEducationButton.setTitle("Done", for: .normal)
        } else {
            if cityTextField.isEnabled == true {
                cityTextField.isEnabled = false
                editEducationButton.setTitle("Edit", for: .normal)
            }
            
        }
        saveDefaultsData()
    }
}


