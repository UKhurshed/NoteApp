//
//  AddNoteViewController.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    private let addNoteViewModel = AddNoteViewModel()
    
    private let successCompletion: () -> Void
    
    init(successCompletion: @escaping () -> Void) {
        self.successCompletion = successCompletion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var addNoteUIView: AddNoteUIView {
        self.view as! AddNoteUIView
    }
    
    override func loadView() {
        view = AddNoteUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNoteUIView.delegate = self
        
        addNoteViewModel.eventHandle = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .success:
                successCompletion()
                self.dismiss(animated: true)
                break
            case .failure(let errorMessage):
                self.presentAlertError(
                    title: R.string.localizable.titleErrorLabel(),
                    message: errorMessage,
                    actionStr: R.string.localizable.alertDismiss())
                break
            }
        }
        
    }
}

extension AddNoteViewController: AddNoteUIViewDelegate {
    func addNote(note: String, priority: Int) {
        if note.isEmpty {
            self.presentAlertError(
                title: R.string.localizable.warningTitle(),
                message: R.string.localizable.noteIsEmpty(),
                actionStr: R.string.localizable.ok())
        } else {
            addNoteViewModel.addNote(note: note, priority: priority)
        }
    }
}
