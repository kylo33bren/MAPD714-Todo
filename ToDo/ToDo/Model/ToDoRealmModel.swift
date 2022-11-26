//
//  ToDoModel.swift
//  Life App
//
//  Created by Brendan Rodrigues on 2022-11-19.
//  Authors:Brendan Rodrigues 301119016, Vatsalkumar Patel 300874931
//  Todo app v 1.5
//
//  25/11/2022
//

import Foundation
import RealmSwift

class ToDoRealmModel:Object{
    @Persisted(primaryKey: true) var id:Int
    @Persisted var name:String
    @Persisted var isCompleted:Bool
    @Persisted var notes:String
    @Persisted var hasDueDate:Bool
    @Persisted var dueDate:String
    
    convenience init(name:String,isCompleted:Bool,notes:String,hasDueDate:Bool,dueDate:String){
        self.init()

        self.id = Int(Date().currentTimeMillis())
        self.name = name
        self.isCompleted = isCompleted
        self.notes = notes
        self.hasDueDate = hasDueDate
        self.dueDate = dueDate
    }

    
    
}


