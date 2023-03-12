//
//  ViewController.swift
//  Simpy Note
//
//  Created by Khin Phone Ei on 12/03/2023.
//

import UIKit
import Floaty

class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register cell
        let cellNib = UINib(nibName: "NoteTableViewCell", bundle: nil)
        noteTableView.register(cellNib, forCellReuseIdentifier: "NoteTableViewCell")
    }
}

extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
        return cell
    }
    
    
}
