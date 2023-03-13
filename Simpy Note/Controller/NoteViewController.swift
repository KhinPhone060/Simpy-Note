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
        
        //longpress on cell
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender: )))
        noteTableView.addGestureRecognizer(longPressRecognizer)
        
        loadNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
    }
}

//MARK: - UI Table View Methods
extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
        cell.configCell(note: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNoteDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NoteDetailViewController
        
        if let indexPath = noteTableView.indexPathForSelectedRow {
            destinationVC.noteTitle = notes[indexPath.row].title
            destinationVC.noteDescription = notes[indexPath.row].noteDescription
            destinationVC.indexId = indexPath.row //0
            destinationVC.notes = notes
        }
    }
}

//MARK: - Data Manipulation
extension NoteViewController {
    func loadNotes(with request: NSFetchRequest<Note> = Note.fetchRequest(),predicate: NSPredicate? = nil) {
        
        if let additionPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionPredicate])
        }
        
        do {
            notes = try context.fetch(request)
        } catch {
            print("Error in loading notes \(error)")
        }
        noteTableView.reloadData()
    }
}

//MARK: - Others
extension NoteViewController {
    @objc func floatyBtnTapped() {
        performSegue(withIdentifier: "goToNoteDetail", sender: self)
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: noteTableView)
            if let indexPath = noteTableView.indexPathForRow(at: touchPoint) {
                let alert = UIAlertController(title: "Delete note", message: "Delete 1 item?", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {_ in
                    
                    //delete note
                    self.context.delete(self.notes[indexPath.row])
                    self.notes.remove(at: indexPath.row)
                    do {
                        try self.context.save()
                    } catch {
                        print("Error in deleting data \(error)")
                    }
                    self.noteTableView.reloadData()
                }
                
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                self.present(alert, animated: true)
            }
        }
    }
}

//MARK: - Search Bar Methods
extension NoteViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadNotes(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadNotes()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
