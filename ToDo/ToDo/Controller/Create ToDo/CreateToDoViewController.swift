//
//  CreateToDoViewController.swift
//  ToDo

//  Created by Brendan Rodrigues on 2022-11-19.
//  Authors:Brendan Rodrigues 301119016, Vatsalkumar Patel 300874931
//  Todo app v 1.5
//
//  24/11/2022
//

import UIKit
import Loaf

enum ScreenType{
    case create
    case edit
}

class CreateToDoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = screenType == .edit ? "Update Todo" : "Create Todo"
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
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
    @IBOutlet weak var deleteBtn: UIButton!{
        didSet{
            deleteBtn.isHidden = screenType == .create
        }
    }
    @IBOutlet weak var saveToDoBtn: UIButton!{
        didSet{
            saveToDoBtn.setTitle(screenType == .create ? "Save" : "Update", for: .normal)
        }
    }
    
    
    @IBOutlet weak var hasDueDateSwitch:UISwitch!
    @IBOutlet weak var isCompletedSwitch:UISwitch!
    
    private var isCompleted = false
    private var hasDueDate = false
    private let viewModel = CreateToDoViewModel()
    
    
    var dbUpdated:(()->Void)?
    var screenType:ScreenType = .create
    var selectedToDo:ToDoRealmModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bindModel(self)
        
        if screenType == .edit{setInitialData()}
        
    }
    
    
    func setInitialData(){
        nameTextField.text = selectedToDo?.name
        notesTextView.text = selectedToDo?.notes
        
        isCompleted = selectedToDo?.isCompleted ?? false
        hasDueDate = selectedToDo?.hasDueDate ?? false

        hasDueDateSwitch.isOn = hasDueDate
        isCompletedSwitch.isOn = isCompleted
        
        
        if selectedToDo?.hasDueDate ?? false{
            datePicker.isHidden = false
            datePicker.date = selectedToDo?.dueDate.toDate() ?? Date()
        }
    }
    
    
    @IBAction func goBack(_ sender:UIButton){
        if screenType == .create{self.navigationController?.popViewController(animated: true); return}
        
        
        let todoModel = ToDoRealmModel(
            name: nameTextField.text ?? "",
            isCompleted: isCompleted,
            notes: notesTextView.text ?? "",
            hasDueDate: hasDueDate,
            dueDate: datePicker.date.toString())
        
        
        viewModel.todoModel = todoModel
        let isModificationOccur = viewModel.checkIfModifcationOccur(selectedToDo: selectedToDo)
        if !isModificationOccur{self.navigationController?.popViewController(animated: true); return}
        
        self.showYesNoAlert(title: "Alert", message: "Are you sure you want to discard chages.") { [self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        
       
    }

    @IBAction func hasDueDateSwitchTapped(_ sender: UISwitch) {
        datePicker.isHidden = !sender.isOn
        hasDueDate = true
    }
    
    @IBAction func isCompletedSwichTapped(_ sender: UISwitch) {
        isCompleted = sender.isOn
    }
    
    
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        
        self.showYesNoAlert(title: "Alert", message: "Are you sure you want to delete it.") { [self] in
            viewModel.deleteToDo(selectedToDo: selectedToDo)
        }
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        hasDueDate = true
    }
    
    @IBAction func createToDoTapped(_ sender: UIButton) {
        
        let todoModel = ToDoRealmModel(
            name: nameTextField.text ?? "",
            isCompleted: isCompleted,
            notes: notesTextView.text ?? "",
            hasDueDate: hasDueDate,
            dueDate: hasDueDate ? datePicker.date.toString() : Date().toString())
        
        viewModel.todoModel = todoModel
        
        let isInputValid = viewModel.isInputValid()
        if isInputValid && screenType == .create {viewModel.saveToDo(); return}
        
        //show alert before updating DB
        self.showYesNoAlert(title: "Alert", message: "Are you sure you want to update it.") { [self] in
            viewModel.updateToDo(selectedToDo: selectedToDo)
        }
        
    }
    
    
}


extension CreateToDoViewController:CreateToDoViewModelProtocol{
    func success(successString:String) {
        Utility.showLoaf(message: successString , state: .success)
        
        dbUpdated?()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func failure(errorString: String) {
        Utility.showLoaf(message: errorString, state: .error)
    }
    
    
}

