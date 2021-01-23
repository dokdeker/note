//
//  EditNoteTableView.swift
//  Note
//
//  Created by Евгений on 09.01.2021.
//

import UIKit

extension NoteViewController {

    
    
    @IBAction func editTableNoteAction(_ sender: Any) {
        
        noteTableView.isEditing.toggle()
//        if patternNoteView == NoteStatus.edit {
            turnEditNoteButton()
//        }
    }
    
    
    func turnEditNoteButton() {
        /// turn off
        if noteTableView.isEditing == false {
            editNoteTableOutlet.setImage(UIImage(systemName: "arrow.up.arrow.down.square"), for: .normal)
            editNoteTableOutlet.tintColor = .systemGray
//            editNoteTableOutlet.titleLabel?.text = "Править"
            enableEditBarButtons(isEndable: true)
//            if patternNoteView == NoteStatus.editTableNote {
//                patternNoteView = NoteStatus.edit
//            }
        /// turn on
        } else {
            editNoteTableOutlet.setImage(UIImage(systemName: "arrow.up.arrow.down.square.fill"), for: .normal)
            
            enableEditBarButtons(isEndable: false)
            editNoteTableOutlet.tintColor = .systemBlue
            noteTableView.reloadData()
            timeButtonAction(isActive: false)
            
//            if patternNoteView == NoteStatus.edit {
//                patternNoteView = NoteStatus.editTableNote
//            }
        }
    }
    
    
    func enableEditBarButtons(isEndable: Bool) {
        checkMarkButton.isEnabled = isEndable
        timeButtonOutlet.isEnabled = isEndable
        redMarkButton.isEnabled = isEndable
        orangeMarkButton.isEnabled = isEndable
        greyMarkButton.isEnabled = isEndable
    }
}
