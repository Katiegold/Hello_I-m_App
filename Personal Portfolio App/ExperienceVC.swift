//
//  ExperienceVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//


//PROBLEMS: experienceCell.detailTextLabel?.text = positionArray[indexPath.row] under cell for row at, and destination.positionInfo = positionArray[index] under override func prepare for segue. problems getting the subtitle attached.

import UIKit

class ExperienceVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var defaultsData = UserDefaults.standard
    var companyArray = [String]()
    var positionArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        companyArray = defaultsData.stringArray(forKey: "companyArray") ?? [String]()
        positionArray = defaultsData.stringArray(forKey: "positionArray") ?? [String]()
    }
    
    func saveDefaultsData() {
        defaultsData.set(companyArray, forKey: "companyArray")
        defaultsData.set(positionArray, forKey: "positionArray")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExperienceEditSegue"{
            let destination = segue.destination as! ExperienceDetailVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.companyInfo = companyArray[index]
            //destination.positionInfo = positionArray[index]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromExperienceDetailVC(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! ExperienceDetailVC
        if let indexPath = tableView.indexPathForSelectedRow {
            companyArray[indexPath.row] = sourceViewController.companyInfo!
            positionArray[indexPath.row] = sourceViewController.positionInfo!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: companyArray.count, section: 0)
            companyArray.append(sourceViewController.companyInfo!)
            positionArray.append(sourceViewController.positionInfo!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveDefaultsData()
    }


    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing{
            tableView.setEditing(false, animated: true)
            addButton.isEnabled = true
            editButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addButton.isEnabled = false
            editButton.title = "Done"
        }
    }
    }

extension ExperienceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let experienceCell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCell", for: indexPath)
        experienceCell.textLabel?.text = companyArray[indexPath.row]
        //experienceCell.detailTextLabel?.text = positionArray[indexPath.row]
        return experienceCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            companyArray.remove(at: indexPath.row)
            positionArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let companyToMove = companyArray[sourceIndexPath.row]
        let positionToMove = positionArray[sourceIndexPath.row]
        companyArray.remove(at: sourceIndexPath.row)
        positionArray.remove(at: sourceIndexPath.row)
        companyArray.insert(companyToMove, at: destinationIndexPath.row)
        positionArray.insert(positionToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
}

    

