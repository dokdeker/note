//
//  CheckMark.swift
//  Note
//
//  Created by Евгений on 06.01.2021.
//

import UIKit
var checkMarkIsOn = Bool()
var amountNewString = Int()


extension NoteViewController  {
    
    
    @IBAction func checkMarkAction(_ sender: Any) {
        
        checkMarkIsOnCheck()
    }
    
    
    func checkMarkIsOnCheck() {

        if  noteCellItems.isEmpty {
            
            ///* add cell
            statusCell = LastCellAction.wasCreatedCheckList
            indexCellFromNoteCell = noteCellItems.count
            print("CheckLisk was created at: \(noteCellItems.count) index")
            createCheckListCell()
            
        } else {
            
            ///* replace cell (delete note and add checklist) if body is empty
            if  noteCellItems[0].body?.isEmpty == true  {
                print(noteCellItems[0].body!)
                print("Cell was deleted at: 0 index")
                deleteCell(index: 0)
                
                statusCell = LastCellAction.wasCreatedCheckList
                indexCellFromNoteCell = noteCellItems.count
                print("CheckLisk was created at: \(noteCellItems.count) index")
                createCheckListCell()
                
            } else {
                ///* add cell
                statusCell = LastCellAction.wasCreatedCheckList
                indexCellFromNoteCell = noteCellItems.count
                print("CheckLisk was created at: \(noteCellItems.count) index")
                createCheckListCell()
            }
        }
    }
    
    
}
