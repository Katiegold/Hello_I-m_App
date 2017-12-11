//
//  ContactVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var linkedInTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    
    @IBOutlet weak var editContactButton: UIButton!
    
    var defaultsData = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = defaultsData.string(forKey: "emailTextField") ?? String()
        phoneTextField.text = defaultsData.string(forKey: "phoneTextField") ?? String()
        linkedInTextField.text = defaultsData.string(forKey: "linkedInTextField") ?? String()
        twitterTextField.text = defaultsData.string(forKey: "twitterTextField") ?? String()

    }
    
    func saveDefaultsData() {
        defaultsData.set(emailTextField.text, forKey: "emailTextField")
        defaultsData.set(linkedInTextField.text, forKey: "linkedInTextField")
        defaultsData.set(phoneTextField.text, forKey: "phoneTextField")
        defaultsData.set(twitterTextField.text, forKey: "twitterTextField")
        
    }

    @IBAction func editContactButtonPressed(_ sender: UIButton) {
        
        if emailTextField.isEnabled == false {
            emailTextField.isEnabled = true
            editContactButton.setTitle("Done", for: .normal)
            emailTextField.becomeFirstResponder()
        } else {
            if emailTextField.isEnabled == true {
                emailTextField.isEnabled = false
                editContactButton.setTitle("Edit", for: .normal)
            }
            
        }
        
    if phoneTextField.isEnabled == false {
    phoneTextField.isEnabled = true
    editContactButton.setTitle("Done", for: .normal)
    } else {
    if phoneTextField.isEnabled == true {
    phoneTextField.isEnabled = false
    editContactButton.setTitle("Edit", for: .normal)
    }
    
    }
    
        if linkedInTextField.isEnabled == false {
            linkedInTextField.isEnabled = true
            editContactButton.setTitle("Done", for: .normal)
        } else {
            if linkedInTextField.isEnabled == true {
                linkedInTextField.isEnabled = false
                editContactButton.setTitle("Edit", for: .normal)
            }
            
        }
        if twitterTextField.isEnabled == false {
            twitterTextField.isEnabled = true
            editContactButton.setTitle("Done", for: .normal)
        } else {
            if twitterTextField.isEnabled == true {
               twitterTextField.isEnabled = false
                editContactButton.setTitle("Edit", for: .normal)
            }
            
        }
        saveDefaultsData()
}

    

}
