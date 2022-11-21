//
//  CreateToDoViewController.swift
//  ToDo
//
//  Created by Hamza Butt on 11/21/22.
//

import UIKit

class CreateToDoViewController: UIViewController {

    @IBOutlet weak var notesTextView: UITextView!{
        didSet{
            notesTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
            notesTextView.layer.borderWidth = 0.5
            notesTextView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!{
        didSet{
            datePicker.isHidden = true
        }
    }
    
    private let hasDueDate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func switchTapped(_ sender: UISwitch) {
        datePicker.isHidden = !sender.isOn
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        print("sender.date ",sender.date)
    }
    
}
