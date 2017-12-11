//
//  BlogsDetailVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/3/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class BlogsDetailVC: UIViewController {

    let defaultsData = UserDefaults.standard
    
    @IBOutlet weak var blogDetail: UITextField!
    @IBOutlet weak var saveBlogButton: UIBarButtonItem!
    @IBOutlet weak var blogContentTextView: UITextView!
    
    var blogTitle: String?
    var blogContent: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let blogTitle = blogTitle {
            blogDetail.text = blogTitle
            self.navigationItem.title = "Edit Blog"
        } else {
            self.navigationItem.title = "New Blog"
        }
        if let blogContent = blogContent {
            blogContentTextView.text = blogContent
        }
        enableDisableSaveBlogButton()
        blogDetail.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromBlogsDetailVC" {
            blogTitle = blogDetail.text
            blogContent = blogContentTextView.text

        }
    }
    

    func enableDisableSaveBlogButton() {
        if let blogCount = blogDetail.text?.count, blogCount > 0 {
            saveBlogButton.isEnabled = true
        } else {
            saveBlogButton.isEnabled = false
        }
    }
    
    @IBAction func blogEditingChanged(_ sender: UITextField) {
        enableDisableSaveBlogButton()
    }
    
    @IBAction func cancelBlogButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

}
