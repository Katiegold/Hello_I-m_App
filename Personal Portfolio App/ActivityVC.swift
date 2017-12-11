//
//  ActivityVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class ActivityVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var defaultData = UserDefaults.standard
    var organizationArray = [String]()
    var positionsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        organizationArray = defaultData.stringArray(forKey: "organizationArray") ?? [String]()
        positionsArray = defaultData.stringArray(forKey: "positionsArray") ?? [String]()
    }
    
    func saveDefaultData() {
        defaultData.set(organizationArray, forKey: "organizationArray")
        defaultData.set(positionsArray, forKey: "positionsArray")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditActivityDetailSegue"{
            let destination = segue.destination as! ActivityDetailVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.organizationInfo = organizationArray[index]
            //destination.positionInfo = positionsArray[index]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromActivityDetailVC(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! ActivityDetailVC
        if let indexPath = tableView.indexPathForSelectedRow {
            organizationArray[indexPath.row] = sourceViewController.organizationInfo!
            positionsArray[indexPath.row] = sourceViewController.positionsInfo!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: organizationArray.count, section: 0)
            organizationArray.append(sourceViewController.organizationInfo!)
            positionsArray.append(sourceViewController.positionsInfo!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveDefaultData()
    }
    
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing{
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
}

extension ActivityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        activityCell.textLabel?.text = organizationArray[indexPath.row]
        //activityCell.detailTextLabel?.text = positionsArray[indexPath.row]
        return activityCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            organizationArray.remove(at: indexPath.row)
            positionsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultData()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let organizationToMove = organizationArray[sourceIndexPath.row]
        let positionsToMove = positionsArray[sourceIndexPath.row]
        organizationArray.remove(at: sourceIndexPath.row)
        positionsArray.remove(at: sourceIndexPath.row)
        organizationArray.insert(organizationToMove, at: destinationIndexPath.row)
        positionsArray.insert(positionsToMove, at: destinationIndexPath.row)
        saveDefaultData()
    }
}




