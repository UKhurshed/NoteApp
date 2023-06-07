//
//  HomeViewModel.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import Foundation


class HomeViewModel {
    
    var eventHandler: ((_ event: Event) -> Void)?
    
    func getAllNotes() {
        do {
            let notes = try CoreDataManager.shared.getAll()
            print("notes: \(notes)")
            eventHandler?(.success(notes: notes))
        } catch let error {
            eventHandler?(.error(errorMessage: error.localizedDescription))
        }
    }
    
    func deleteNote(note: NoteEntity) {
        do  {
            try CoreDataManager.shared.deleteNote(note: note)
            getAllNotes()
        } catch let error {
            eventHandler?(.error(errorMessage: error.localizedDescription))
        }
    }
}

extension HomeViewModel {
    enum Event {
        case success(notes: [NoteEntity])
        case error(errorMessage: String)
    }
}
