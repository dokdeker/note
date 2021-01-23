//
//  NoteTableViewDelegate.swift
//  Note
//
//  Created by Евгений on 04.01.2021.
//

import UIKit

extension NoteViewController: UITableViewDelegate {
    
    
    //MARK: - TableView willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
        tableView.backgroundColor = UIColor.clear
    }
    
    
    //MARK: - Tapped Cell -> Start action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
    }
    
    
       
    
    
    
}
















//MARK: - UITableViewDataSource
extension NoteViewController: UITableViewDataSource {
    //MARK: - Set amount of cells in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var amountCell: Int = 0
        amountCell = noteCellItems.count
        
        return amountCell
    }
    
    
    //MARK: - Set propertys for cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableCell
        
        cell.setupNoteCell(isCheckList: noteCellItems[indexPath.row].isCheckList ?? false,
                           isDone: noteCellItems[indexPath.row].isDone ?? false,
                           markColor: Note.colorMark,
                           body: noteCellItems[indexPath.row].body ?? "hello",
                           statusEditNote: patternNoteView,
                           indexPath: indexPath)
        
        cell.updateNoteDelegate = self
        
        
        
        //MARK: Setup focus to cell:
        
        /// - When cell was delete move focus to preview cell
        if indexPath.row == indexCellFromNoteCell && statusCell == LastCellAction.wasDeleted {
            print("indexCellFromNoteCell del: \(indexCellFromNoteCell)")
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    cell.textBody.becomeFirstResponder()
                    self.noteTableView.scrollToRow(at: IndexPath(row: indexCellFromNoteCell, section: 0), at: .bottom, animated: true)
                }
            }
            adaptiveScrollForKeyboard()
            statusCell = ""
        }
        
        
        /// - When cell was created move focus to new cell
        if  indexPath.row == indexCellFromNoteCell
                && (statusCell == LastCellAction.wasCreatedCheckList
                || statusCell == LastCellAction.wasCreatedNote) {
            
            print("indexCellFromNoteCell cre checklist: \(indexCellFromNoteCell)")
            
            if statusCell == LastCellAction.wasCreatedNote {
                cell.textBody.text = "444 "
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    cell.textBody.becomeFirstResponder()
                }
            }
            
            adaptiveScrollForKeyboard()
            statusCell = ""
            
        }
        
        
        /// When open create note window - focus move to 1 cell
        if  indexPath.row == 0 && statusCell == LastCellAction.wasOpenCreateNote {
            print("indexCellFromNoteCell wasOpenCreateNote")

            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    cell.textBody.becomeFirstResponder()
                    
                }
            }
            statusCell = ""
        }
        
        
        
        return cell
    }
    
    
    
    //MARK: - Edit Style
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    
    // MARK: - EDIT: Move sells
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let chosedCell = noteCellItems[sourceIndexPath.row]
        
        noteCellItems.remove(at: sourceIndexPath.row)
        
        noteCellItems.insert(chosedCell, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    
    // MARK: - <- swipe cell - DELETE
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        if patternNoteView == NoteStatus.edit {
            
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                
                noteCellItems.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .left)
                completionHandler(true)
                self.noteTableView.reloadData()
            }
            
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            
            return configuration
        }
        
        return nil
    }
    
    
}

