//
//  ChecklistViewController.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import UIKit

class AllListsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var allLists: [Checklist] = []
    let cellIdentifier = "ChecklistCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        generateDummyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: -Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CheckViewController,
           segue.identifier == "showItems" {
            destination.checklist = (sender as! Checklist)
        }
        
        if let destination = segue.destination as? ListDetailTableViewController {
            destination.delegate = self
            
          if let cell = sender as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell),
               segue.identifier == "editList" {
                    destination.listToEdit = allLists[indexPath.row]
                }
        
            }
        }
    
    // MARK: - Helper
    private func generateDummyData() {
        allLists.append(Checklist("Have a coffee"))
        allLists.append(Checklist("Brush my teeth"))
        allLists.append(Checklist("Walk the dog"))
        allLists.append(Checklist("Have a standup"))
        allLists.append(Checklist("Code some apps"))
    }
}

extension AllListsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let recycledCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = recycledCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel?.text = allLists[indexPath.row].name
        cell.detailTextLabel?.text = "\(allLists[indexPath.row].countUncheckedItems()) Remaining"
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
}

extension AllListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = allLists[indexPath.row]
        performSegue(withIdentifier: "showItems", sender: checklist)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "ListDetailTableViewController") as! ListDetailTableViewController
        let checklist = allLists[indexPath.row]
        
        controller.listToEdit = checklist
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        allLists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: -ListDetailTableViewControllerDelegate
extension AllListsViewController: ListDetailTableViewControllerDelegate {
    func listDetailViewControllerDidCancel(_ controller: ListDetailTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailTableViewController, didFinishAddingList list: Checklist) {
        let newRowIndex = allLists.count
        allLists.append(list)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailTableViewController, didFinishEditing list: Checklist) {
       if let index = allLists.firstIndex(of: list) {
            let indexPath = IndexPath(row: index, section: 0)
    
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = list.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}
