//
//  EditNoteViewController.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    private let editViewModel = EditViewModelImpl()
    private let noteEntity: NoteEntity
    private let successCompletion: () -> Void
    
    init(note: NoteEntity, successCompletion: @escaping () -> Void) {
        self.noteEntity = note
        self.successCompletion = successCompletion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var editNoteUIView: EditNoteUIView {
        self.view as! EditNoteUIView
    }
    
    override func loadView() {
        view = EditNoteUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.editNote()
        editNoteUIView.delegate = self
        
        observeEvent()
        
        editNoteUIView.setupData(note: noteEntity.note ?? "", priority: Int(noteEntity.priority))
    }
    
    private func observeEvent() {
        editViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .success:
                successCompletion()
                navigationController?.popViewController(animated: true)
                break
            case .failure(let errorMessage):
                self.presentAlertError(message: errorMessage)
                break
            }
        }
    }
    
    private func presentAlertError(message: String) {
        print("error message: \(message)")
        DispatchQueue.main.async {
            let alert  = UIAlertController(title: R.string.localizable.titleErrorLabel(), message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.alertDismiss(), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension EditNoteViewController: EditNoteUIViewDelegate {
    func editTapped(note: String, priority: Int) {
        editViewModel.editNote(noteEntity: self.noteEntity, note: note, priority: priority)
    }
}
