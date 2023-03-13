//
//  TaskViewController.swift
//  Simpy Note
//
//  Created by Khin Phone Ei on 12/03/2023.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
