//
//  TextLogic.swift
//  Note
//
//  Created by Евгений on 11.12.2020.
//
import UIKit

extension NoteViewController: UITextViewDelegate, UITextFieldDelegate {
    
    //MARK: - colorize TextView
    func updateColorise() {
        var color = UIColor()
        var colorTextView = UIColor()
        
        switch Note.colorMark {
        case ColorMark.gray:
            color = .gray
        case ColorMark.orange:
            color = .systemOrange
        case ColorMark.red:
            color = .systemRed
        default:
            break
        }

        colorTextView =  UIColor { tc in
            switch tc.userInterfaceStyle {
            case .dark:
                return UIColor.white
                
            case .light:
                return UIColor.black
            default:
                return UIColor.white
            }
        }
        
//        let colorizedPointMarkTextView = NSMutableAttributedString(fullString: textView.text, fullStringColor: colorTextView,
//                                              subString: "●", subStringColor: color)
//
//        textView.attributedText = colorizedPointMarkTextView
//        textView.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    
    //MARK: - Switch from body to head
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        self.textView.resignFirstResponder()
//        self.headTextFieldOutlet.resignFirstResponder()
    }
    
    
    //MARK: - Check text after editing
    func textViewDidChange(_ textView: UITextView) {
        
        checkEmptyNote()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        checkPlaceholderNote()
    }
    
    
    //MARK: - Check StatusNote for pattern note
    @IBAction func headTextFieldEditing(_ sender: Any) {
        
        if  headTextFieldOutlet.text?.isEmpty == true && patternNoteView == NoteStatus.create {
            createButtonOutlet.isEnabled = false
            createButtonOutlet.tintColor = .gray
            
        } else if (headTextFieldOutlet.text?.isEmpty == false ) && patternNoteView == NoteStatus.create{
            
            createButtonOutlet.isEnabled = true
            createButtonOutlet.tintColor = .systemBlue
        }
    }
    
    
    //MARK: - Create note default
    func checkEmptyHead(){
        
        if headTextFieldOutlet.text?.isEmpty == true  {
            headTextFieldOutlet.text = "Новая заметка \(todayNoteItems.count + 1)"
            Note.head = headTextFieldOutlet.text!
            
        } else {
            Note.head = headTextFieldOutlet.text!
        }
    }
    
    
    //MARK: - block/unblock "CREATE" button
    func checkEmptyNote(){
        
//        if textView.text?.isEmpty == true && headTextFieldOutlet.text?.isEmpty == true && patternNoteView == NoteStatus.create {
//            createButtonOutlet.isEnabled = false
//            createButtonOutlet.tintColor = .gray
//
//        } else if (textView.text?.isEmpty == false ) && patternNoteView == NoteStatus.create{
//
//            createButtonOutlet.isEnabled = true
//            createButtonOutlet.tintColor = .systemBlue
//        }
    }
    
    
    //MARK: - add "●" After touched retun keyboard button
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if pointMarkActiveStatus == true {
            if(text == "\n") {
                textView.text += "\n\n●    "
                updateColorise()
                
                return false
            }
        }
        
        if numberMarkActiveStatus == true {
            if(text == "\n") {
                markNumber += 1
                textView.text += "\n\(markNumber + 1).    "
                updateColorise()
                
                return false
            }
        }
        return true
    }
    
    
    //MARK: - Go from HEAD to BODY after retun keyboard button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        textField.becomeFirstResponder()
//        textView.becomeFirstResponder()
        return true
    }
    
    
    //MARK: - remove Placeholder TextView
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView.text == "Введите вашу заметку" {
            textView.text = ""
            textView.alpha = 0.7
        }
        
        return true
    }
    
    //MARK: - create Placeholder TextView
    func checkPlaceholderNote(){
        
//        if textView.text?.isEmpty == true {
//            textView.text = "Введите вашу заметку"
//            textView.alpha = 0.3
//        }
    }
    
    
    //MARK: - Adaptive area size Text View when keyboard is show or hide
    func createAdaptiveAreaSizeTextView() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAreaSizeTextView), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAreaSizeTextView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func returnDefoultScrollRange(){
//        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        textView.scrollIndicatorInsets = textView.contentInset
//
//        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    
    @objc func updateAreaSizeTextView(param: Notification) {
        let userInfo = param.userInfo
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        
        
        if param.name == UIResponder.keyboardWillHideNotification {
            noteTableView.contentInset = UIEdgeInsets.zero
        } else {
            noteTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            noteTableView.scrollIndicatorInsets = noteTableView.contentInset
        }
        noteTableView.scrollToRow(at: IndexPath(row: indexCellFromNoteCell, section: 0), at: .bottom, animated: true)
        
//        if param.name == UIResponder.keyboardWillHideNotification {
//            textView.contentInset = UIEdgeInsets.zero
//        } else {
//            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
//            textView.scrollIndicatorInsets = textView.contentInset
//        }
//        textView.scrollRangeToVisible(textView.selectedRange)
        
    }
}


extension UITextView{
    func calcAmountOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }
}

extension NSMutableAttributedString {
    
    convenience init (fullString: String, fullStringColor: UIColor, subString: String, subStringColor: UIColor) {
        
        let str = fullString
        
        var searchRange = str.startIndex..<str.endIndex
        
        
        
        let attributedString = NSMutableAttributedString(string:fullString)
        
        let rangeOfFullString = NSRange(location: 0, length: fullString.count)//fullString.range(of: fullString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fullStringColor, range: rangeOfFullString)
        
//        let rangeOfSubString = (fullString as NSString).range(of: subString)
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: subStringColor, range: rangeOfSubString)
        
        while let range = str.range(of: subString, options: NSString.CompareOptions.caseInsensitive, range: searchRange) {
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: subStringColor, range: NSRange(range, in: str))
            searchRange = range.upperBound..<searchRange.upperBound
        }
        
        
        
        self.init(attributedString: attributedString)
    }

}
