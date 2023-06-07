//
//  CoreDataManager.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Note")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func createNote(noteLabel: String, priority: Int) throws -> NoteEntity {
        
        let note = NoteEntity(context: viewContext)
        note.note = noteLabel
        note.createdAt = Date()
        note.isComplete = false
        note.priority = Int32(priority)
    
        try viewContext.save()
       
        
        return note
    }
    
    func getAll() throws -> [NoteEntity] {
        let notes = try viewContext.fetch(NoteEntity.fetchRequest())
        return notes
    }
    
    func deleteNote(note: NoteEntity) throws {
        viewContext.delete(note)
        
        try viewContext.save()
    }
    
    func updateNote(note: NoteEntity, newNote: String, priority: Int) throws {
        note.note = newNote
        note.priority = Int32(priority)
        
        try viewContext.save()
    }
}
