//
//  ListDetailTableViewController.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import UIKit

protocol ListDetailTableViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailTableViewController)
    func listDetailViewController(_ controller: ListDetailTableViewController, didFinishAddingList list: Checklist)
    func listDetailViewController(_ controller: ListDetailTableViewController, didFinishEditing list: Checklist)
}

class ListDetailTableViewController: UITableViewController {
    
    // MARK: -IBOutlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: -Properties
    weak var delegate: ListDetailTableViewControllerDelegate?
    var listToEdit: Checklist?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let list = listToEdit {
            title = "Edit List"
            textField.text = list.name
            doneButton.isEnabled = true
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }

    // MARK: -IBAction
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = listToEdit {
            checklist.name = textField.text!
            delegate?.listDetailViewController(self, didFinishEditing: checklist)
            
            return
        }
        
        let checklist = Checklist(textField.text!)
        delegate?.listDetailViewController(self, didFinishAddingList: checklist)
    }
}

extension ListDetailTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneButton.isEnabled = !newText.isEmpty
        
        return true
    }
}
