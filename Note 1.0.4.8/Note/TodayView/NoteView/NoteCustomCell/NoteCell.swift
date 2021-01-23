//
//  NoteCell.swift
//  Note
//
//  Created by Евгений on 04.01.2021.
//

import UIKit


extension NoteTableCell: NoteCellDelegate {
    func resignKeyboard() {
        textBody.resignFirstResponder()
        print("22222222")
    }
}

var becomeFirstResponceForCell = Bool()
var indexCellFromNoteCell = Int()


protocol NoteDelegate {
    func rewriteEditedCell()
    
    func reloadNoteTable()
    func reloadCell()
    func printSmth()
    
    func createNoteCell()
    func createCheckListCell()
    func deleteCell(index:Int)
    
    func checkPatternNote()
    
    func checkCheckMarkButton()
    
    func adaptiveScrollForKeyboard()
}


enum LastCellAction {
    static var wasCreatedCheckList = "wasCreatedCheckList"
    static var wasCreatedNote = "wasCreatedNote"
    static var wasDeleted = "wasDeleted"
    static var wasOpenCreateNote = "wasOpenCreateNote"
    
}

var statusCell = String()

class NoteTableCell: UITableViewCell, UITextViewDelegate {
    var updateNoteDelegate: NoteDelegate?
    var placeHolderTextView = "Введите текст"
    var currentCell = ""
    
    
    // MARK: - Outlets
    @IBOutlet weak var textBody: UITextView!
    @IBOutlet weak var bodyLeftConst: NSLayoutConstraint!
    @IBOutlet weak var checkMarkOutlet: UIButton!

    
    // MARK: - Tapped Checkmark button
    @IBAction func checkMarkAction(_ sender: Any) {
        
        
        ///* - TurnON checkmark
        if noteCellItems[checkMarkOutlet.tag].isCheckList == true
            && noteCellItems[checkMarkOutlet.tag].isDone == false {
            
            stickthought(text: textBody, isOn: true)
            
            checkMarkOutlet.setImage(UIImage(systemName: "checkmark.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
            noteCellItems[checkMarkOutlet.tag].isDone = true
            textBody.alpha = 0.35
          
            
        ///* - TurnOFF checkmark
        } else if noteCellItems[checkMarkOutlet.tag].isCheckList == true
                    && noteCellItems[checkMarkOutlet.tag].isDone == true {
            
            stickthought(text: textBody, isOn: false)
            updateNoteDelegate?.reloadNoteTable()

            checkMarkOutlet.setImage(UIImage(systemName: "square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
            noteCellItems[checkMarkOutlet.tag].isDone = false
            textBody.alpha = 0.8
        }
        
        
        ///* - Save checkmark change
        todayNoteItems[usedIndexCell].noteCell = noteCellItems
    }
    
    
    
    
    
    
    // MARK: - SETUP NOTE CELL
    func setupNoteCell(isCheckList:Bool,
                       isDone: Bool,
                       markColor: String,
                       body: String,
                       statusEditNote: String,
                       indexPath:IndexPath) {
        
        
        DispatchQueue.global().async {
            //вычисляем фоном
            DispatchQueue.main.async {
                // переносим вычисление в основной поток
            }
        }
        
        checkMarkOutlet.tag = Int(indexPath.row)
        textBody.delegate = self
        textBody.tag = Int(indexPath.row)
        textBody.text = body
        
        checkPlaceHolder(IsOn: true)
        

        
        //MARK: - Set type of cell (Checklist or note)
        
        ///* - Checklsit:
        if isCheckList == true {
            
            bodyLeftConst.constant = 60
            checkMarkOutlet.isHidden = false
            
        ///* - Note:
        } else {
            bodyLeftConst.constant = 14
            checkMarkOutlet.isHidden = true
        }
        
        
        //MARK: - Set color of CheckMark
        switch markColor {
        
        case ColorMark.red:
            checkMarkOutlet.tintColor = .systemRed
            
        case ColorMark.orange:
            checkMarkOutlet.tintColor = .systemOrange
            
        case ColorMark.gray:
            checkMarkOutlet.tintColor = .systemGray
        default:
            break
        }
        
        
        //MARK: - Set isDone
        
        ///* - If isDone = false
        if noteCellItems[checkMarkOutlet.tag].isCheckList == true
            && noteCellItems[checkMarkOutlet.tag].isDone == false {
            
            checkMarkOutlet.setImage(UIImage(systemName: "square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
            textBody.alpha = 0.8
            
            
        ///* - If isDone = true
        } else if noteCellItems[checkMarkOutlet.tag].isCheckList == true
                    && noteCellItems[checkMarkOutlet.tag].isDone == true {
            
            checkMarkOutlet.setImage(UIImage(systemName: "checkmark.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
            textBody.alpha = 0.35
            
            stickthought(text: textBody, isOn: true)
            
            
        ///* - last check for note
        } else if noteCellItems[checkMarkOutlet.tag].isCheckList == false && noteCellItems[checkMarkOutlet.tag].isDone == false {
            textBody.alpha = 0.8
        }
        
    }
    
    
    
    func stickthought(text: UITextView, isOn: Bool = true, sizeText: CGFloat = 17.0) {
        if isOn {
            let attributeString =  NSMutableAttributedString(string: text.text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: NSUnderlineStyle.single.rawValue,
                                         range: NSMakeRange(0, attributeString.length))

            text.attributedText = attributeString
            text.font = UIFont(descriptor: text.font!.fontDescriptor, size: sizeText)

        } else {
            let attributeString =  NSMutableAttributedString(string: text.text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: NSUnderlineStyle.single.rawValue,
                                         range: NSMakeRange(0, attributeString.length))


            text.font = UIFont(descriptor: text.font!.fontDescriptor, size: sizeText)
        }
        
        checkColorTextBody()

    }
    
}


