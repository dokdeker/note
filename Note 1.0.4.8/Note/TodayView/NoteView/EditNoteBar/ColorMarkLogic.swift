//
//  ColorMarkLogic.swift
//  Note
//
//  Created by Евгений on 03.01.2021.
//

import UIKit

extension NoteViewController  {
    
    @IBAction func tappedMark(_ sender: Any) {
        let mark = sender as! UIButton
        
        if mark.restorationIdentifier == "red" {
            setColor(pressed: mark, set: ColorMark.red)
        }
        
        if mark.restorationIdentifier == "orange" {
            setColor(pressed: mark, set: ColorMark.orange)
        }
        
        if mark.restorationIdentifier == "gray" {
            setColor(pressed: mark, set: ColorMark.gray)
        }
    }
    
    
    func setColor(pressed mark: UIButton, set color: String) {
        
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4,
                       options: .curveEaseIn ) { [self] in
            
            redMarkButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            orangeMarkButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            greyMarkButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            
            redMarkButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            orangeMarkButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            greyMarkButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            
            switch color {
            
            case ColorMark.red:
                headTextFieldOutlet.textColor = .systemRed
                redMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                redMarkButton.transform = .identity
                
            case ColorMark.orange:
                headTextFieldOutlet.textColor = .systemOrange
                orangeMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                orangeMarkButton.transform = .identity
                
            case ColorMark.gray:
                headTextFieldOutlet.textColor = .gray
                greyMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
                greyMarkButton.transform = .identity
                
            default:
                break
            }
            
        }
        
        Note.colorMark = color
        
        updateColorise()
    }
    
}
