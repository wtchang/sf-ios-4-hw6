//
//  NotesTableViewController.swift
//  iOS4-HW6
//
//  Created by Kathryn Rotondo on 2/15/16.
//  Copyright © 2016 Kathryn Rotondo. All rights reserved.
//


import UIKit
import CoreData

class NotesTableViewController: UITableViewController, NoteDelegate {
    
   let managedContext = sharedContext()
   var notes:[Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Core Data
    
    // save the data to disk
    func saveData(noteText:String) {
        // create a new managed object
        // and insert it into the context
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: managedContext)
        let note = Note(entity:entity!, insertIntoManagedObjectContext: managedContext)
        // set its attributes
        note.text = noteText
        
        // commit changes to disk
        do {
            try managedContext.save()
            print("Saved Note")
            notes.append(note)
            tableView.reloadData()
            
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    // load the data from disk
    func loadData() {
        // create fetch request
        let fetchRequest = NSFetchRequest(entityName: "Note")
        // ask managedcontext to make the request
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            // if successful store result
            notes = results as! [Note]
        } catch let error as NSError {
            print("Could not load \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    } 
    
    // MARK: - Note Delegate
    
    func saveNote(noteText: String) {
        saveData(noteText)

    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCellIdentifier", forIndexPath: indexPath)
        
        // Configures the cell...

        /* USE THIS BLOCK WITH STRING
        let note = notes[indexPath.row]
        let minimum = min(20, note.characters.count)
        let breakIndex = note.startIndex.advancedBy(minimum)
        cell.textLabel?.text = note.substringToIndex(breakIndex)
        cell.detailTextLabel?.text = note.substringFromIndex(breakIndex)
        */
        
        // Note Block
        if let text = notes[indexPath.row].text {
            let minimum = min(20, text.characters.count)
            let breakIndex = text.startIndex.advancedBy(minimum)
            cell.textLabel?.text = text.substringToIndex(breakIndex)
            cell.detailTextLabel?.text = text.substringFromIndex(breakIndex)
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Gets the new view controller
        let addNoteVC = segue.destinationViewController as! AddNoteViewController
        
        // Passes self as NoteDelegate to the new view controller
        addNoteVC.delegate = self
    }
    
}
