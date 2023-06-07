//
//  ViewState.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import Foundation

enum HomeViewState {
    case success(notes: [NoteEntity])
    case failure(errorMessage: String)
}
