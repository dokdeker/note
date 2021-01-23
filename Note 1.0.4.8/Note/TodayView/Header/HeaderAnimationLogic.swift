//
//  HeaderController.swift
//  Note
//
//  Created by Евгений on 21.12.2020.
//

import UIKit

extension TodayViewController {
    enum Header {
        static var fold:String = "fold"
        static var unFold: String = "unFold"
        static var defaultSize: String = "defaultSize"
        static var free: String = "free"
        static var isDragging:Bool = true
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        //MARK: - Swipe DOWN = UNFOLD Header
        
        if offsetY < 0 &&
            
            headerHeight.constant <= 100 &&
            headerStatus != Header.unFold &&
            headerStatus != Header.defaultSize {
            
            headerHeight.constant += (offsetY * -1)/2
            
            headerStatus = Header.unFold
            loadPatternHeader(animation: Header.unFold)
            
            
            checkDate()
        }
        
        
        //MARK: - Swipe DOWN and release = DEFAULT Size Header
        if offsetY < 0 && Header.isDragging == false {
            Header.isDragging = true
            headerHeight.constant += (offsetY * -1)/2
            headerStatus = Header.defaultSize
            loadPatternHeader(animation: Header.defaultSize)
        }
        
        
        //MARK: - Swipe UP = FOLD Header
        if offsetY > 0 && headerHeight.constant > 40{
            headerHeight.constant -= offsetY/2
            
            headerStatus = Header.fold
            loadPatternHeader(animation: Header.fold)
            Header.isDragging = false
        } else if headerHeight.constant < 40 {
            headerHeight.constant = 40
        }
    }
    
    //MARK: - End Dragging = FOLD DEFAULT Size Header
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if headerHeight.constant > 70 {
            headerStatus = Header.defaultSize
            loadPatternHeader(animation: Header.defaultSize)
        }
    }
    
    
    //MARK: - scrollDidEnd
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        headerStatus = Header.free
    }
    
    
    
    
    //MARK: - loadPatternHeader Animation
    func loadPatternHeader(animation: String) {
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: .curveEaseIn)  { [self] in
            
            switch animation {
            
            case Header.fold:
                
                todayButtonStackViewOutlet.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
                todayLabel.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
                todayLabelLeftConst.constant = 3
                todayButStackRightConst.constant = 5
                dateLabel.alpha = 0
                view.layoutIfNeeded()
                
                
            case Header.unFold:
                
                todayButtonStackViewOutlet.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                todayLabel.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                dateLabel.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
                todayLabelLeftConst.constant = 20
                todayButStackRightConst.constant = 20
                headerHeight.constant = 100
                dateLabel.alpha = 1
                view.layoutIfNeeded()
                
            case Header.defaultSize:
                
                todayButtonStackViewOutlet.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                dateLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                todayLabel.transform = .identity
                todayLabelLeftConst.constant = 20
                todayButStackRightConst.constant = 20
                headerHeight.constant = 70
                dateLabel.alpha = 1
                
                view.layoutIfNeeded()
                
            default:
                break
            }
        }
    }
    
}
