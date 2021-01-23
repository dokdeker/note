//
//  PaternSorting.swift
//  Note
//
//  Created by Евгений on 20.12.2020.
//

import UIKit


extension SortViewController {
    
    
    //MARK: - Sort Array Pattern
    func sortArray() {
        
        var red = [NoteData]()
        var orange = [NoteData]()
        var gray = [NoteData]()
        
        var resultSort = [NoteData]()
        
        
        for i in 0..<todayNoteItems.count {
            switch todayNoteItems[i].colorMark {
            case ColorMark.red:
                red.append(todayNoteItems[i])
                
            case ColorMark.orange:
                orange.append(todayNoteItems[i])
                
            case ColorMark.gray:
                gray.append(todayNoteItems[i])
                
            default:
                break
            }
        }
        
        switch patternSort {
        case Sort.moreImportantUp:
            resultSort += red + orange + gray
            todayNoteItems = resultSort
        case Sort.lessImportantUp:
            resultSort += gray + orange + red
            todayNoteItems = resultSort
        default:
            break
            
    //        var colorMarkRed = [String]()
    //        var colorMarkOrange = [String]()
    //        var colorMarkGray = [String]()
    //        var resultColorMark = [String]()
    //
    //        var headRed = [String]()
    //        var headOrange = [String]()
    //        var headGray = [String]()
    //        var resultHead = [String]()
    //
    //        var bodyRed = [String]()
    //        var bodyOrange = [String]()
    //        var bodyGray = [String]()
    //        var resultBody = [String]()
    //
    //        var isDoneRed = [Bool]()
    //        var isDoneOrange = [Bool]()
    //        var isDoneGray = [Bool]()
    //        var resultIsDone = [Bool]()
    //
    //        var isFoldRed = [Bool]()
    //        var isFoldOrange = [Bool]()
    //        var isFoldGray = [Bool]()
    //        var resultisFold = [Bool]()
    //
    //        var amountLineRed = [Int]()
    //        var amountLineOrange = [Int]()
    //        var amountLineGray = [Int]()
    //        var resultAmountLine = [Int]()
            
            
//            switch NoteData.colorMark[i] {
//            case ColorMark.red:
//                colorMarkRed.append(NoteData.colorMark[i])
//                headRed.append(NoteData.head[i])
//                bodyRed.append(NoteData.body[i])
//                isDoneRed.append(NoteData.isDone[i])
//                isFoldRed.append(NoteData.isFold[i])
//                amountLineRed.append(NoteData.amountLine[i])
//
//            case ColorMark.orange:
//                colorMarkOrange.append(NoteData.colorMark[i])
//                headOrange.append(NoteData.head[i])
//                bodyOrange.append(NoteData.body[i])
//                isDoneOrange.append(NoteData.isDone[i])
//                isFoldOrange.append(NoteData.isFold[i])
//                amountLineOrange.append(NoteData.amountLine[i])
//
//            case ColorMark.gray:
//                colorMarkGray.append(NoteData.colorMark[i])
//                headGray.append(NoteData.head[i])
//                bodyGray.append(NoteData.body[i])
//                isDoneGray.append(NoteData.isDone[i])
//                isFoldGray.append(NoteData.isFold[i])
//                amountLineGray.append(NoteData.amountLine[i])
//
//            default:
//                break
//            }
        }
        
//        if patternSort == Sort.moreImportantUp {
//            resultColorMark += colorMarkRed + colorMarkOrange + colorMarkGray
//            NoteData.colorMark = resultColorMark
//            
//            resultHead += headRed + headOrange + headGray
//            NoteData.head = resultHead
//            
//            resultBody += bodyRed + bodyOrange + bodyGray
//            NoteData.body = resultBody
//            
//            resultIsDone += isDoneRed + isDoneOrange + isDoneGray
//            NoteData.isDone = resultIsDone
//            
//            resultisFold += isFoldRed + isFoldOrange + isFoldGray
//            NoteData.isFold = resultisFold
//            
//            resultAmountLine += amountLineRed + amountLineOrange + amountLineGray
//            NoteData.amountLine = resultAmountLine
//            
//        }
//        
//        
//        if patternSort == Sort.lessImportantUp {
//            resultColorMark += colorMarkGray + colorMarkOrange + colorMarkRed
//            NoteData.colorMark = resultColorMark
//            
//            resultHead += headGray + headOrange + headRed
//            NoteData.head = resultHead
//            
//            resultBody += bodyGray + bodyOrange + bodyRed
//            NoteData.body = resultBody
//            
//            resultIsDone += isDoneGray + isDoneOrange + isDoneRed
//            NoteData.isDone = resultIsDone
//            
//            resultisFold += isFoldGray + isFoldOrange + isFoldRed
//            NoteData.isFold = resultisFold
//            
//            resultAmountLine += amountLineGray + amountLineOrange + amountLineRed
//            NoteData.amountLine = resultAmountLine
//        }
        
        
        
    }
    
    
}
