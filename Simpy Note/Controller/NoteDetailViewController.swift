//
//  NoteDetailViewController.swift
//  Simpy Note
//
//  Created by Khin Phone Ei on 12/03/2023.
//

import UIKit
import CoreData
import Toast

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addedDateLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var notes = [Note]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var noteTitle: String?
    var noteDescription: String?
    var addedDate: String?
    var indexId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = noteTitle
        descriptionTextField.text = noteDescription
        addedDateLabel.text = addedDate ?? getTodayDate()
        
        saveBtn.isEnabled = false
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if titleTextField.text != "" || descriptionTextField.text != "" {
            saveNotes()
        }
    }
}

//MARK: - UITextFieldDelegate & UITextViewDelegate
extension NoteDetailViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if titleTextField.text != "" {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if descriptionTextField.text != "" {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
}

//MARK: - Data Manipulation
extension NoteDetailViewController {
    
    @IBAction func savePressed(_ sender: UIButton) {
        self.saveNotes()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.navigateBackToHome()
    }
    
    func saveNotes() {
        if indexId != nil {
            //update note
            notes[indexId!].setValue(titleTextField.text, forKey: "title")
            notes[indexId!].setValue(descriptionTextField.text, forKey: "noteDescription")
            notes[indexId!].setValue(addedDateLabel.text, forKey: "addedDate")
            self.view.makeToast("Saved")
        } else {
            //add new note
            let newNote = Note(context: context)
            newNote.title = titleTextField.text!
            newNote.noteDescription = descriptionTextField.text
            newNote.addedDate = getTodayDate()
            self.notes.append(newNote)
            self.view.makeToast("Saved")
        }
        
        //save the changes to context
        do {
            try context.save()
        } catch {
            print("Error in saving context \(error)")
        }
    }
    
    func getTodayDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
}
