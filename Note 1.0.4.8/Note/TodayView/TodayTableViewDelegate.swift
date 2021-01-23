//
//  TodayDelegate.swift
//  Note
//
//  Created by Евгений on 14.12.2020.
//

import UIKit
//MARK: UITableViewDelegate
var usedIndexCell = Int()
extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch todayNoteItems[indexPath.row].isFold {
        
        
        case true:
            let amountLineCell = todayNoteItems[indexPath.row].amountLine
            
            return 56 + (16.5 * CGFloat(amountLineCell))
            
        default:
            
            return 60
            
        }
        
    }
    
    
    //MARK: - Edit Style
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
         return .none
    }
    
    
    //MARK: - TableView willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
    }
    
    
    //MARK: -> swipe cell - Note is DONE
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if todayNoteItems[indexPath.row].isDone == false {
//        if NoteData.isDone[indexPath.row] == false {
            let doneAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                
                let cell = tableView.cellForRow(at: indexPath) as! CustomCell
                cell.backgroundColor = UIColor.clear

                cell.setupTodayCell(headText: todayNoteItems[indexPath.row].head,
                           noteText: todayNoteItems[indexPath.row].body,
                           markColor: todayNoteItems[indexPath.row].colorMark,
                           isDone: true,
                           isFold: todayNoteItems[indexPath.row].isFold,
                           amountLine: todayNoteItems[indexPath.row].amountLine,
                           startTime: todayNoteItems[indexPath.row].startTime ?? "",
                           endTime: todayNoteItems[indexPath.row].endTime ?? "",
                           cell: cell)

                
                cell.isDoneAnimation(isFold: todayNoteItems[indexPath.row].isFold)
                todayNoteItems[indexPath.row].isDone = true
//                NoteData.isDone[indexPath.row] = true
                self.saveTodayData()
                completionHandler(true)
            }
            
            doneAction.image = UIImage(named: "check-mark")?.withTintColor(.white)
            doneAction.backgroundColor = .systemGreen
            
            let configuration = UISwipeActionsConfiguration(actions: [doneAction])
            return configuration
            
        } else {
            
            let doneAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                let cell = tableView.cellForRow(at: indexPath) as! CustomCell
                cell.backgroundColor = UIColor.clear
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn ){ [] in
                    cell.setupTodayCell(headText: todayNoteItems[indexPath.row].head,
                               noteText: todayNoteItems[indexPath.row].body,
                               markColor: todayNoteItems[indexPath.row].colorMark,
                               isDone: false,
                               isFold: todayNoteItems[indexPath.row].isFold,
                               amountLine: todayNoteItems[indexPath.row].amountLine,
                               startTime: todayNoteItems[indexPath.row].startTime ?? "",
                               endTime: todayNoteItems[indexPath.row].endTime ?? "",
                               cell: cell)

                }
                todayNoteItems[indexPath.row].isDone = false
//                NoteData.isDone[indexPath.row] = false
                self.saveTodayData()
                completionHandler(true)
                
            }
            
            doneAction.image = UIImage(systemName: "multiply")
            doneAction.backgroundColor = .systemGray
            
            let configuration = UISwipeActionsConfiguration(actions: [doneAction])
            return configuration
            
        }
    }
    
    
    
    // MARK: - <- swipe cell - DELETE
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            
            todayNoteItems.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .left)
            self.checkEnableHeadButton()
            self.saveTodayData()
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        
        // MARK: - <- swipe cell - FOLD CELL
        if todayNoteItems[indexPath.row].amountLine > 0 {
            switch todayNoteItems[indexPath.row].isFold {
            
            case true:
                let foldCell = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                    
                    todayNoteItems[indexPath.row].isFold = false
                    tableView.reloadRows(at: [indexPath], with: .fade)
                    completionHandler(true)
                    
                    self.saveTodayData()
                }
                
                foldCell.image = UIImage(systemName: "arrow.down.forward.and.arrow.up.backward")
                foldCell.backgroundColor = .systemGray
                
                let configuration = UISwipeActionsConfiguration(actions: [deleteAction, foldCell])
                return configuration
                
            case false:
                
                let foldCell = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                    
                    todayNoteItems[indexPath.row].isFold = true
                    tableView.reloadRows(at: [indexPath], with: .fade)
                    completionHandler(true)
                    
                    self.saveTodayData()
                    
                }
                
                foldCell.image = UIImage(systemName: "arrow.up.left.and.arrow.down.right")
                foldCell.backgroundColor = .systemGray
                let configuration = UISwipeActionsConfiguration(actions: [deleteAction, foldCell])
                return configuration
            }
        } else {
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
    }
    
    
    // MARK: - EDIT: Move sells
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let chosedCell = todayNoteItems[sourceIndexPath.row]
        
        todayNoteItems.remove(at: sourceIndexPath.row)
        
        todayNoteItems.insert(chosedCell, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    
    
    // MARK: - Tapped Cell -> Start action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        patternNoteView = NoteStatus.read
        
        Note.head = todayNoteItems[indexPath.row].head
        Note.body = todayNoteItems[indexPath.row].body
        Note.colorMark = todayNoteItems[indexPath.row].colorMark
        Note.isFold = todayNoteItems[indexPath.row].isFold
        
        if todayNoteItems[indexPath.row].startTime != nil && todayNoteItems[indexPath.row].startTime != "" {
            Note.startTime = todayNoteItems[indexPath.row].startTime!
        } else {
            Note.startTime = ""
        }
        
        if todayNoteItems[indexPath.row].endTime != nil && todayNoteItems[indexPath.row].endTime != "" {
            Note.endTime = todayNoteItems[indexPath.row].endTime!
        } else {
            Note.endTime = ""
        }
        
        noteCellItems = todayNoteItems[indexPath.row].noteCell
        
        
        

        usedIndexCell = indexPath.row
        
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        performSegue(withIdentifier: "noteViewId", sender: nil)
    }
}
