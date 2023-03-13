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
    
    var tasks = [Task]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        
        loadTasks()
    }
}

//MARK: - Table View Methods
extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.configCell(task: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].done = !tasks[indexPath.row].done
        self.saveTasks()
        taskTableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Data Manipulation Methods
extension TaskViewController {
    func saveTasks() {
        do{
            try context.save()
        } catch {
            print("Error in saving context \(error)")
        }
        self.taskTableView.reloadData()
    }
    
    func loadTasks(with request: NSFetchRequest<Task> = Task.fetchRequest(),predicate: NSPredicate? = nil) {
        do {
           tasks = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        taskTableView.reloadData()
    }
}

//MARK: - Others
extension TaskViewController {
    @objc func floatyBtnTapped() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newTask = Task(context: self.context)
            newTask.title = textField.text!
            newTask.done = false
            self.tasks.append(newTask)
            self.saveTasks()
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
