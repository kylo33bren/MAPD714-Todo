//
//  CreateToDoViewModel.swift
//  ToDo
//
//  Created by Brendan Rodrigues on 2022-11-19.
//  Authors:Brendan Rodrigues 301119016, Vatsalkumar Patel 300874931
//  Todo app v 1.5
//  Database intialized using realm swift
//
//  24/11/2022
//

import Foundation

protocol CreateToDoViewModelProtocol{
    func success(successString:String)
    func failure(errorString:String)
}

class CreateToDoViewModel{
    
    var delegete:CreateToDoViewModelProtocol?
    
    
    var todoModel:ToDoRealmModel?
    
    
    
    func bindModel(_ delegete:CreateToDoViewModelProtocol){
        self.delegete = delegete
    }
    
    
    func isInputValid()->Bool{
        var errorString = ""
        
        if todoModel?.name == ""{
            errorString = "Name cannot be empty"
        }else if todoModel?.notes == ""{
            errorString = "Notes cannot be empty"
        }
        
        
        if errorString != ""{
            delegete?.failure(errorString: errorString)
            return false
        }
        
        return true
    }
    
    func checkIfModifcationOccur(selectedToDo:ToDoRealmModel?)->Bool{
        if selectedToDo?.name != todoModel?.name || selectedToDo?.notes != todoModel?.notes || selectedToDo?.isCompleted != todoModel?.isCompleted || selectedToDo?.hasDueDate != todoModel?.hasDueDate {
            return true
        }
        return false
    }
    
    
    func saveToDo(){
        guard let toDo = todoModel else {return}
        let isSaved = realmDB().write(toDo)
        isSaved ? delegete?.success(successString: "Todo created successfully") :  delegete?.failure(errorString: "Cannot able to save ToDo")
    }
    
    func updateToDo(selectedToDo:ToDoRealmModel?){
        let isUpdated = realmDB().update {
            selectedToDo?.name = todoModel?.name ?? ""
            selectedToDo?.notes = todoModel?.notes ?? ""
            selectedToDo?.isCompleted = todoModel?.isCompleted ?? false
            selectedToDo?.hasDueDate = todoModel?.hasDueDate ?? false
            selectedToDo?.dueDate = todoModel?.dueDate ?? ""
        }
        isUpdated ? delegete?.success(successString: "Todo updated successfully") :  delegete?.failure(errorString: "Cannot able to update ToDo")
    }
    
    func deleteToDo(selectedToDo:ToDoRealmModel?){
        guard let selectedToDo = selectedToDo else {return}
        let isDeleted = realmDB().delete(selectedToDo)
        isDeleted ? delegete?.success(successString: "Todo deleted successfully") :  delegete?.failure(errorString: "Cannot able to delete ToDo")
    }
    
    
    
    
}
