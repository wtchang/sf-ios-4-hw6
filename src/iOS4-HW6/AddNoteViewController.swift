//
//  AddNoteViewController.swift
//  iOS4-HW6
//
//  Created by Kathryn Rotondo on 2/15/16.
//  Copyright © 2016 Kathryn Rotondo. All rights reserved.
//

import UIKit

protocol NoteDelegate {
    func saveNote(note:String)
}

class AddNoteViewController: UIViewController {
    
    var delegate:NoteDelegate?
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        delegate?.saveNote(noteTextView.text)
        navigationController?.popViewControllerAnimated(true)
    }
}
