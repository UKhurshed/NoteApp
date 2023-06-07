//
//  EditViewModel.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import Foundation

protocol EditViewModel {
    func editNote(noteEntity: NoteEntity, note: String, priority: Int)
}

class EditViewModelImpl: EditViewModel {
    
    var eventHandler: ((_ event: EditViewState) -> Void)?
    
    func editNote(noteEntity: NoteEntity, note: String, priority: Int) {
        do {
            try CoreDataManager.shared.updateNote(note: noteEntity, newNote: note, priority: priority)
            eventHandler?(.success)
        } catch let error {
            eventHandler?(.failure(errorMessage: error.localizedDescription))
        }
    }
}
