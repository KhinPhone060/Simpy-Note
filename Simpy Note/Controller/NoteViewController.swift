//
//  ViewController.swift
//  Simpy Note
//
//  Created by Khin Phone Ei on 12/03/2023.
//

import UIKit
import Floaty
import CoreData

class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTableView: UITableView!
    
    var notes = [Note]()
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
        
        noteTableView.addSubview(floaty)
        
        //register cell
        let cellNib = UINib(nibName: "NoteTableViewCell", bundle: nil)
        noteTableView.register(cellNib, forCellReuseIdentifier: "NoteTableViewCell")
        
        loadNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
    }
}

//MARK: - UI Table View Delegate and DataSource
extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
        cell.configCell(note: notes[indexPath.row])
        return cell
    }
}

//MARK: - Data Manipulation
extension NoteViewController {
    func loadNotes(with request: NSFetchRequest<Note> = Note.fetchRequest()) {
        do {
            notes = try context.fetch(request)
        } catch {
            print("Error in loading notes \(error)")
        }
        noteTableView.reloadData()
    }
    
    
}

//MARK: - Navigate
extension NoteViewController {
    @objc func floatyBtnTapped() {
        self.navigateToNoteDetail()
    }
}
