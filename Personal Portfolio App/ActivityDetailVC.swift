//
//  ActivityDetailVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class ActivityDetailVC: UIViewController {
    @IBOutlet weak var organizationDetail: UITextField!
    @IBOutlet weak var positionsDetail: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!

    var organizationInfo: String?
    var positionsInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let organizationInfo = organizationInfo {
            organizationDetail.text = organizationInfo
            self.navigationItem.title = "Edit Activity"
        } else {
            self.navigationItem.title = "New Activity"
        }
        if let positionsInfo = positionsInfo {
            positionsDetail.text = positionsInfo
        }
        enableDisableSaveBarButton()
        organizationDetail.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromActivityDetailVC" {
            organizationInfo = organizationDetail.text
            positionsInfo = positionsDetail.text
        }
    }
    
    
    func enableDisableSaveBarButton() {
        if let organizationCount = organizationDetail.text?.count, organizationCount > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func organizationEditingChanged(_ sender: UITextField) {
        enableDisableSaveBarButton()
    }

    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    }

