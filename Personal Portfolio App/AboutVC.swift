//
//  AboutVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var editAboutButton: UIButton!
    @IBOutlet weak var aboutTextView: UITextView!
    
    var defaultsData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTextView.text = defaultsData.string(forKey: "aboutTextView") ?? String()
    }
    
    func saveDefaultsData() {
        defaultsData.set(aboutTextView.text, forKey: "aboutTextView")
    }
    
    
    
    @IBAction func editAboutButtonPressed(_ sender: UIButton) {
        if aboutTextView.isEditable == false {
            aboutTextView.isEditable = true
            editAboutButton.setTitle("Done", for: .normal)
            aboutTextView.becomeFirstResponder()
        } else {
            if aboutTextView.isEditable == true {
            aboutTextView.isEditable = false
            editAboutButton.setTitle("Edit", for: .normal)
        }
    }
    
    saveDefaultsData()
    }
    
    
    

}
