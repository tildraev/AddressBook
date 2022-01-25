//
//  PersonTableViewController.swift
//  Address Book
//
//  Created by Arian Mohajer on 1/24/22.
//

import UIKit

class PersonTableViewController: UITableViewController {

    // MARK: - Properties
    var group: Group?
    
    // MARK: - IBOutlets
    @IBOutlet weak var groupNameTextField: UITextField!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let group = group,
           let groupName = groupNameTextField.text {
            group.name = groupName
            GroupController.sharedInstance.saveContactsToDisk()
        }
    }
    
    // MARK: - Table view data source
    
    func updateUI() {
        if let group = group {
            groupNameTextField.text = group.name
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let group = group {
            return group.people.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        guard let person = group?.people[indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.address
        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let group = group {
                PersonController.deletePerson(person: group.people[indexPath.row], group: group)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let index = tableView.indexPathForSelectedRow,
               let destination = segue.destination as? DetailViewController {
                let person = group?.people[index.row]
                destination.person = person
                destination.group = group
            }
        } else if segue.identifier == "addNewPerson" {
            let destination = segue.destination as? DetailViewController
            destination?.group = group
        }
    }
}
