//
//  CustomCellAnimations.swift
//  Note
//
//  Created by Евгений on 14.12.2020.
//

import UIKit

extension CustomCell {
    
    //MARK: - Animation cell element
    func isDoneAnimation(isFold:Bool) {
        markAnimation()
        headAnimation()
        bodyAnimation(isFold: isFold)
        timeAnimations()
    }
    
    //MARK: - Time
    func timeAnimations() {
        UIView.animate(withDuration: 0.7, delay: 0.4,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 1,
                       options: .curveEaseIn ) { [self] in
            
            startTimeLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.8,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 1,
                       options: .curveEaseIn ){ [self] in
            
            startTimeLabel.transform = .identity
//            startTimeLabel.alpha = 0
        }
        
        
        UIView.animate(withDuration: 0.7, delay: 0.45,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 1,
                       options: .curveEaseIn ) { [self] in
            
            endTimeLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.85,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 1,
                       options: .curveEaseIn ){ [self] in
            
            endTimeLabel.transform = .identity
//            endTimeLabel.alpha = 0
        }
    
    }
    
    
    
    
    //MARK: - Mark
    func markAnimation() {
        
        UIView.animate(withDuration: 0.7, delay: 0.3,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1,
                       options: .curveEaseIn ) { [self] in
            
            mark.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.8,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1,
                       options: .curveEaseIn ){ [self] in
            
            mark.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            mark.alpha = 0
        }
    }
    
    
    //MARK: - Head
    func headAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.2,
                       options: .curveEaseIn ) { [self] in
            headLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.7,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0,
                       options: .curveEaseIn ){ [self] in
            headLabel.transform = .identity
        }
    }
    
    
    //MARK: - Body
    func bodyAnimation(isFold: Bool) {
        UIView.animate(withDuration: 0.7, delay: 0.3,
                       options: .curveEaseIn ) { [self] in
            if isFold == true {
                noteLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9).translatedBy(x: 0, y: 30)
            } else {
                noteLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.8,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0,
                       options: .curveEaseIn ){ [self] in
            noteLabel.transform = .identity
        }
    }
    
}
    
