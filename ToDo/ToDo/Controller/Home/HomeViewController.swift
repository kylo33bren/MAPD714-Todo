//
//  ViewController.swift
//  ToDo
//
//  Created by Brendan Rodrigues on 2022-11-19.
//  Authors:Brendan Rodrigues 301119016, Vatsalkumar Patel 300874931
//  Todo app v 1.5
//
//  24/11/2022
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
        }
    }
    
    
    private let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bindModel(self)
        viewModel.getToDoList()
    }
    
    @IBAction func addToDoTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateToDoViewController") as! CreateToDoViewController
        vc.dbUpdated = {self.viewModel.getToDoList()}
        self.navigationController?.pushViewController(vc, animated: true)
    }


}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as! ToDoTableViewCell
        cell.setData(item: viewModel.toDoList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateToDoViewController") as! CreateToDoViewController
        vc.dbUpdated = {self.viewModel.getToDoList()}
        vc.selectedToDo = viewModel.toDoList[indexPath.row]
        vc.screenType = .edit
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



extension HomeViewController:HomeViewModelProtocol{
    func success() {
        tableView.reloadData()
    }
    
    func failure(errorString: String) {
        Utility.showLoaf(message: errorString, state: .error)
    }
    
    
}


