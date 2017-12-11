//
//  BlogsVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class BlogsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBlogButton: UIBarButtonItem!
    @IBOutlet weak var editBlogButton: UIBarButtonItem!
    
    var blogsArray = [String]()
    var blogsContentArray = [String]()
    var defaultsDatas = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        blogsArray = defaultsDatas.stringArray(forKey: "blogsArray") ?? [String]()
        blogsContentArray = defaultsDatas.stringArray(forKey: "blogsContentArray") ?? [String]()
    }

    
    func saveDefaultsDatas() {
        defaultsDatas.set(blogsArray, forKey: "blogsArray")
        defaultsDatas.set(blogsContentArray, forKey: "blogsContentArray")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditBlogDetailSegue"{
            let destination = segue.destination as! BlogsDetailVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.blogTitle = blogsArray[index]
            destination.blogContent = blogsContentArray[index]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }

    }
    
    @IBAction func unwindFromBlogsDetailVC(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! BlogsDetailVC
        if let indexPath = tableView.indexPathForSelectedRow {
            blogsArray[indexPath.row] = sourceViewController.blogTitle!
            blogsContentArray[indexPath.row] = sourceViewController.blogContent ?? ""
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: blogsArray.count, section: 0)
            blogsArray.append(sourceViewController.blogTitle!)
            blogsContentArray.append((sourceViewController.blogContent)!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveDefaultsDatas()
    }
    
    
    @IBAction func editBlogButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing{
            tableView.setEditing(false, animated: true)
            addBlogButton.isEnabled = true
            editBlogButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBlogButton.isEnabled = false
            editBlogButton.title = "Done"
        }
    }
}

extension BlogsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let blogCell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath)
        blogCell.textLabel?.text = blogsArray[indexPath.row]
        return blogCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            blogsArray.remove(at: indexPath.row)
            blogsContentArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsDatas()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let blogsTitlesToMove = blogsArray[sourceIndexPath.row]
        let blogContentToMove = blogsContentArray[sourceIndexPath.row]
        blogsArray.remove(at: sourceIndexPath.row)
        blogsContentArray.remove(at: sourceIndexPath.row)
        blogsArray.insert(blogsTitlesToMove, at: destinationIndexPath.row)
        blogsArray.insert(blogContentToMove, at: destinationIndexPath.row)
        saveDefaultsDatas()
    }
}





