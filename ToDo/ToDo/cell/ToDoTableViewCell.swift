//
//  ToDoTableViewCell.swift
//  Life App
//
//  Created by Brendan Rodrigues on 2022-11-19.
//  Authors:Brendan Rodrigues 301119016, Vatsalkumar Patel 300874931
//  Todo app v 1.5
//
//  26/11/2022

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var toDoStackView: UIStackView!{
        didSet{
            toDoStackView.isHidden = true
        }
    }
    
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setData(item:ToDoRealmModel){
        titleLabel.text = item.name
        descriptionLabel.text = item.notes
        bgView.backgroundColor = item.isCompleted ? .gray : .white
        
        
        //setting time view
        if item.hasDueDate{
            toDoStackView.isHidden = false
            timeLabel.text = item.dueDate
            timeLabel.textColor = item.dueDate.toDate() > Date() ? .green : .red
        }else{
            toDoStackView.isHidden = true
        }
        
        
        
       
    }

    
}
