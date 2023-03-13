//
//  TaskViewController.swift
//  Simpy Note
//
//  Created by Khin Phone Ei on 12/03/2023.
//

import UIKit
import Floaty
import CoreData

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //floating action button
        let floaty = Floaty()
        floaty.sticky = true
        floaty.buttonColor = UIColor(named: "AccentColor")!
        floaty.plusColor = UIColor.white
        
        //add gesture for floaty btn
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.floatyBtnTapped))
        floaty.addGestureRecognizer(gesture)
        
        taskTableView.addSubview(floaty)

        //register cell
        let cellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        taskTableView.register(cellNib, forCellReuseIdentifier: "TaskTableViewCell")
    }
}

//MARK: - Table View Methods
extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        return cell
    }
}

//MARK: - Others
extension TaskViewController {
    @objc func floatyBtnTapped() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true)
    }
}
