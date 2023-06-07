//
//  AddNoteViewModel.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import Foundation

class AddNoteViewModel {
    
    var eventHandle: ((_ event: AddNoteViewState) -> Void)?
    
    func addNote(note: String, priority: Int) {
        do {
            let noteEntity = try CoreDataManager.shared.createNote(noteLabel: note, priority: priority)
            print("addNote note: \(noteEntity)")
            eventHandle?(.success)
        } catch let error {
            eventHandle?(.failure(errorMessage: error.localizedDescription))
        }
    }
}
