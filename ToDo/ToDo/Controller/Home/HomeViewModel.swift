//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Brendan Rodrigues on 2022-11-19.
//  Authors:Brendan Rodrigues 301119016, Vatsalkumar Patel 300874931
//  Todo app v 1.5  
//
//  24/11/2022
//

import Foundation
protocol HomeViewModelProtocol{
    func success()
    func failure(errorString:String)
}

class HomeViewModel{
    
    var toDoList = [ToDoRealmModel]()
    var delegete:HomeViewModelProtocol?
    
    
    func bindModel(_ delegete:HomeViewModelProtocol){
        self.delegete = delegete
    }
    
    func getToDoList(){
        toDoList = realmDB().fetchData(ToDoRealmModel.self)
        delegete?.success()
    }
    
   
}
