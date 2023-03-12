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
        
        //floating action button
        let floaty = Floaty()
        floaty.sticky = true
        floaty.buttonColor = UIColor(named: "AccentColor")!
        floaty.plusColor = UIColor.white
        
        //add gesture for floaty btn
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.floatyBtnTapped))
        floaty.addGestureRecognizer(gesture)
        
        noteTableView.addSubview(floaty)
        
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

extension NoteViewController {
    @objc func floatyBtnTapped() {
        self.navigateToNoteDetail()
    }
}
