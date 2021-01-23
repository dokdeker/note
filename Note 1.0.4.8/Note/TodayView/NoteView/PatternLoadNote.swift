//
//  patternNote.swift
//  Note
//
//  Created by Евгений on 11.12.2020.
//
import UIKit

enum NoteStatus {
    static var create = "create"
    static var edit = "edit"
    static var editTableNote = "editTableNote"
    static var read = "read"
}

var patternNoteView = String()

//MARK: - Load Pattern Note
extension NoteViewController {
    
    func loadPatternNote() {
        
        
        
        switch patternNoteView {
        
        case NoteStatus.create:
            statusCell = LastCellAction.wasOpenCreateNote
            noteCellItems = [NoteCell(isCheckList: false, isDone: false, body: "")]
            timeView.alpha = 0
            
            headLabelTopConst.constant = 5
            fromHeadToColorMarkBar.constant = 10
            timeView.isHidden = true
            Note.startTime = ""
            Note.endTime = ""
            Note.isFold = false
            setColor(pressed: greyMarkButton, set: ColorMark.gray)
            isModalInPresentation = true
            pointMarkActiveStatus = false
            
            //            textView.isEditable = true
            headTextFieldOutlet.isEnabled = true
            
            editbuttonOutlet.isHidden = true
            
            stackViewMarks.isHidden = false
            headViewLabel.isHidden = false
            
            createButtonOutlet.isHidden = false
            canselButtonOutlet.isHidden = false
            
            slider.alpha = 0
            headViewLabel.alpha = 100
            
        case NoteStatus.edit:
//            reloadNoteTable()
            checkTimeActive()
//            setColor(pressed: greyMarkButton, set: todayNoteItems[usedIndexCell].colorMark)
            isModalInPresentation = true
            
            checkMarkIsOn = false
            pointMarkActiveStatus = false
            
            stackViewMarks.isHidden = false
            headViewLabel.isHidden = false
            
            createButtonOutlet.isHidden = true
            canselButtonOutlet.isHidden = true
            
            headTextFieldOutlet.isEnabled = true
            
            
            
            
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn ){ [self] in
                headLabelTopConst.constant = -17
                fromHeadToColorMarkBar.constant = 10
                headViewLabel.alpha = 0
                slider.alpha = 0
                view.layoutIfNeeded()
            }
            
            
            
            
            
        case NoteStatus.read:
            
            editNoteTableOutlet.setImage(UIImage(systemName: "arrow.up.arrow.down.square"), for: .normal)
            editNoteTableOutlet.tintColor = .systemGray
            enableEditBarButtons(isEndable: true)
            
            noteTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            giveTimeToTimePickerFromUsedCell()
            
            setColor(pressed: greyMarkButton, set: todayNoteItems[usedIndexCell].colorMark)
            
            isModalInPresentation = false
            
//            timeView.isHidden = true
            
            noteTableView.isEditing = false
            pointMarkActiveStatus = false
            
            headViewLabel.isHidden = true
            
            createButtonOutlet.isHidden = true
            canselButtonOutlet.isHidden = true
            
            headTextFieldOutlet.text = Note.head
            headTextFieldOutlet.isEnabled = false
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: { [self] in
                headLabelTopConst.constant = -80
                fromHeadToColorMarkBar.constant = 50
                slider.alpha = 1
                timeView.alpha = 0
                noteTableView.register(UINib(nibName: "NoteTableCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
                view.layoutIfNeeded()
                
            }) { [self] (completed) in
                
                stackViewMarks.isHidden = true
                timeView.isHidden = true
            }
        default:
            
            break
        }
        
    }
    
}
