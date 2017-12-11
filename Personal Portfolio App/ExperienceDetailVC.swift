//
//  ExperienceDetailVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class ExperienceDetailVC: UIViewController {
    @IBOutlet weak var companyDetail: UITextField!
    @IBOutlet weak var positionDetail: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var companyInfo: String?
    var positionInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let companyInfo = companyInfo {
            companyDetail.text = companyInfo
            self.navigationItem.title = "Edit Experience"
        } else {
            self.navigationItem.title = "New Experience"
        }
        if let positionInfo = positionInfo {
            positionDetail.text = positionInfo
        }
        enableDisableSaveButton()
        companyDetail.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromExperienceDetailVC" {
            companyInfo = companyDetail.text
            positionInfo = positionDetail.text
        }
    }
    
    
    func enableDisableSaveButton() {
        if let companyCount = companyDetail.text?.count, companyCount > 0 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func companyEditingChanged(_ sender: UITextField) {
        enableDisableSaveButton()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
        navigationController?.popViewController(animated: true)
        }
    }
    


    }

