//
//  NoteCellTextLogic.swift
//  Note
//
//  Created by Евгений on 09.01.2021.
//

import UIKit

extension NoteTableCell {
    
    func checkColorTextBody() {
        textBody.textColor =  UIColor { tc in
            switch tc.userInterfaceStyle {
            case .dark:
                return UIColor.white
                
            case .light:
                return UIColor.black
            default:
                return UIColor.white
            }
        }
    }
    
    // MARK: - Text logics
    func textViewDidChange(_ textView: UITextView) {
        
        
        noteCellItems[textBody.tag].body = textBody.text
//        Note.body = textBody.text
        indexCellFromNoteCell = textBody.tag
        updateNoteDelegate?.reloadCell()
        
        

        updateNoteDelegate?.adaptiveScrollForKeyboard()
        
        
    }
    

    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        indexCellFromNoteCell = textBody.tag
        print(indexCellFromNoteCell)
        
        if noteCellItems[checkMarkOutlet.tag].isCheckList == true {
            currentCell = "cl"
        } else {
            currentCell = "n"
        }
//        if textBody.text == placeHolderTextView {
            checkPlaceHolder(IsOn: false)
//        if textBody.text == placeHolderTextView {
//            textBody.text = nil
//
//            checkColorTextBody()
//        }
//        }
        
//
        if patternNoteView != NoteStatus.edit {
            
        print("1111111111")
            updateNoteDelegate?.checkPatternNote()
            updateNoteDelegate?.adaptiveScrollForKeyboard()
        }
        textBody.becomeFirstResponder()
        
        
        ///* - When i start edit textBody change noteView to edit status
//        if patternNoteView == NoteStatus.read {
//            updateNoteDelegate?.checkPatternNote()
//
//
//        }
        
        
    }
    
   
    
    func textViewDidEndEditing(_ textView: UITextView) {
        checkPlaceHolder(IsOn: true)

    }
    
    func checkPlaceHolder( IsOn: Bool) {
        if IsOn == false {
            if textBody.text == placeHolderTextView {
                textBody.text = nil
                
                checkColorTextBody()
            }
        }
        
        if IsOn == true {
            if textBody.text.isEmpty {
                textBody.text = placeHolderTextView
                textBody.textColor = UIColor.lightGray
            } else {
                checkColorTextBody()
                
            }
            
            
            
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        /// - create Checklist after (Done in Checklist) if cell is not nil
        if (text == "\n")
            && noteCellItems[checkMarkOutlet.tag].isCheckList == true
            && textBody.text != "" {
//            currentCell = "nil"
            indexCellFromNoteCell = textBody.tag + 1
            //            print(indexCellFromNoteCell)
            statusCell = LastCellAction.wasCreatedCheckList
            updateNoteDelegate?.createCheckListCell()
            
        }
        
        
        /// - DELETE current cell if it is nil and CREATE Note after (Done in Checklist)
        if (text == "\n")
            && noteCellItems[checkMarkOutlet.tag].isCheckList == true
            && textBody.text.isEmpty
//            && statusCell == LastCellAction.wasCreatedCheckList
        {
            
            indexCellFromNoteCell = textBody.tag
            
            updateNoteDelegate?.deleteCell(index: textBody.tag)
            statusCell = LastCellAction.wasCreatedNote
            updateNoteDelegate?.createNoteCell()
            
//            textBody.text = "1"
            
        }
        
        /// - Delete cell after (Done in cell) if cell is nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [self] in
//            if statusCell != "" {
                let  char = textBody.text.cString(using: String.Encoding.utf8)!
                let isBackSpace = strcmp(char, "\\b")
                
                if (isBackSpace == -92) && textBody.text == "" {
                    
                    print("Backspace was pressed")
                    indexCellFromNoteCell = textBody.tag - 1
                    statusCell = LastCellAction.wasDeleted
                    updateNoteDelegate?.deleteCell(index: textBody.tag)
                    
                }
//            }
        })
        
        print("22222211")
        return true
    }
    

//    //MARK: - Adaptive area size Text View when keyboard is show or hide
//    func createAdaptiveAreaSizeTextView() {
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateAreaSizeTextView), name: UIResponder.keyboardDidShowNotification, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateAreaSizeTextView), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
//    func returnDefoultScrollRange(){
////        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        textView.scrollIndicatorInsets = textView.contentInset
////
////        textView.scrollRangeToVisible(textView.selectedRange)
//    }
//    
//    
//    @objc func updateAreaSizeTextView(param: Notification) {
//        let userInfo = param.userInfo
//        let noteView = NoteViewController()
////        let viewNote = updateNoteDelegate?.getView()
//        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let keyboardFrame = viewNote!.convert(getKeyboardRect, to: viewNote?.window)
//        
//        
//        if param.name == UIResponder.keyboardWillHideNotification {
//            textBody.contentInset = UIEdgeInsets.zero
//        } else {
//            textBody.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
//            textBody.scrollIndicatorInsets = textBody.contentInset
//        }
//        textBody.scrollRangeToVisible(textBody.selectedRange)
////        textBody.scrollToRow(at: IndexPath(row: indexCellFromNoteCell, section: 0), at: .none, animated: true)
//        
////        if param.name == UIResponder.keyboardWillHideNotification {
////            textView.contentInset = UIEdgeInsets.zero
////        } else {
////            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
////            textView.scrollIndicatorInsets = textView.contentInset
////        }
////        textView.scrollRangeToVisible(textView.selectedRange)
//        
//    }
    

}
