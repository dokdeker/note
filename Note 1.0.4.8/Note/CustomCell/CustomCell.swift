//
//  CustomCell.swift
//  Table&Collection
//
//  Created by Евгений on 09.12.2020.
//

import UIKit

var amountLableLineCell:[Int] = []

class CustomCell: UITableViewCell {
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var mark: UIView!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var checkMark: UIImageView!
    
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var startLabelRightConst: NSLayoutConstraint!
    @IBOutlet weak var startLabelTopConst: NSLayoutConstraint!
    @IBOutlet weak var endTimeBottomConst: NSLayoutConstraint!
    @IBOutlet weak var endTimeRightConst: NSLayoutConstraint!
    @IBOutlet weak var viewTimeHeight: NSLayoutConstraint!
    
    //MARK: - SetUp cell
    func setupTodayCell(headText: String,
               noteText: String,
               markColor: String,
               isDone: Bool,
               isFold: Bool,
               amountLine: Int,
               startTime: String = "",
               endTime: String = "",
               cell:UITableViewCell) {
        
        headLabel.text = headText
        noteLabel.text = noteText
        
        //MARK: - MarkColor
        switch markColor {
        
        case ColorMark.red:
            mark.backgroundColor = .systemRed
            
//            startTimeLabel.textColor = .systemRed
//            endTimeLabel.textColor = .systemRed
            
        case ColorMark.orange:
            mark.backgroundColor = .systemOrange
            
//            startTimeLabel.textColor = .systemOrange
//            endTimeLabel.textColor = .systemOrange
            
        case ColorMark.gray:
            mark.backgroundColor = .systemGray
            
//            startTimeLabel.textColor = .systemGray
//            endTimeLabel.textColor = .systemGray
            
        default:
            break
        }
        
        
        
//        if noteLabel.text?.isEmpty == true {
//            headTopConst.constant = 20
//        } else {
//            headTopConst.constant = 10
//        }
        
        
        
        //MARK: - Time
        
//        viewTime.layer.shadowColor = UIColor.black.cgColor
//        viewTime.layer.shadowOpacity = 0.25
//        viewTime.layer.shadowOffset = .init(width: -4, height: 4)
//        viewTime.layer.shadowRadius = 2
        
        if startTime == "" && endTime == ""{
            viewTime.alpha = 0
        } else {
            viewTime.alpha = 1
        }
        
        startTimeLabel.alpha = 0.9
        endTimeLabel.alpha = 0.9
        startTimeLabel.textColor = .none
        endTimeLabel.textColor = .none
        
        if startTime != "" && endTime == ""{
            startTimeLabel.text = "\(startTime)"
            viewTimeHeight.constant = 26
            startTimeLabel.font = UIFont(descriptor: startTimeLabel.font.fontDescriptor, size: 14.0)
            startLabelTopConst.constant = 7
            startLabelRightConst.constant = 16
//            startTimeLabel.alpha = 1
            endTimeLabel.alpha = 0
        }
        
        if startTime == "" && endTime != ""{
            viewTimeHeight.constant = 26
            endTimeLabel.text = "до \(endTime)"
            endTimeLabel.font = UIFont(descriptor: endTimeLabel.font.fontDescriptor, size: 14.0)
            endTimeBottomConst.constant = 2
            endTimeRightConst.constant = 16
//            endTimeLabel.alpha = 1
            startTimeLabel.alpha = 0
        }
        
        
        if startTime != "" && endTime != ""{
            viewTimeHeight.constant = 40
            
            startTimeLabel.font = UIFont(descriptor: startTimeLabel.font.fontDescriptor, size: 13.0)
            startLabelRightConst.constant = 16
            startLabelTopConst.constant = 3
//            startTimeLabel.alpha = 1
            startTimeLabel.text = "c \(startTime)"
            
            endTimeLabel.font = UIFont(descriptor: endTimeLabel.font.fontDescriptor, size: 13.0)
            endTimeRightConst.constant = 16
            endTimeBottomConst.constant = 3
//            endTimeLabel.alpha = 1
            endTimeLabel.text = "до \(endTime)"
        }
        
        
        
        
        //MARK: - Check cell note IsDone
        if isDone == true {
            
            //mark.backgroundColor = .systemGreen
            UIView.animate(withDuration: 1.4, delay: 0,
                           usingSpringWithDamping: 1, initialSpringVelocity: 1,
                           options: .curveEaseIn ) { [self] in
                
//                switch markColor {
//                case ColorMark.red:
//                    checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemRed)
//
//                case ColorMark.orange:
//                    checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemOrange)
//
//                case ColorMark.gray:
//                    checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemGray)
//
//                default:
//                    break
//                }
//                viewTime.backgroundColor = .systemGray2
//                startTimeLabel.alpha = 0.3
//                endTimeLabel.alpha = 0.3
                
                
                
                
                if startTime != "" {
                    startTimeLabel.alpha = 0.25
                }
                if  endTime != "" {
                    endTimeLabel.alpha = 0.25
                }
                startTimeLabel.textColor = .none
                endTimeLabel.textColor = .none
                
                
                
                
                checkMark.image = UIImage(named: "checkMark1")?.withTintColor(.systemGreen)
                
                
                checkMark.alpha = 1
                checkMark.transform = .identity
                
                headLabel.alpha = 0.5
                noteLabel.alpha = 0.4
                
                mark.alpha = 0
            }
            
        } else {
            
            UIView.animate(withDuration: 1.4, delay: 0,
                           usingSpringWithDamping: 1, initialSpringVelocity: 1,
                           options: .curveEaseIn ) { [self] in
                
//                viewTime.backgroundColor = .systemGray
//                startTimeLabel.alpha = 0.8
//                endTimeLabel.alpha = 0.8
                
                
                
                checkMark.alpha = 0
                checkMark.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                
                headLabel.alpha = 0.9
                noteLabel.alpha = 0.6
                
                
                mark.transform = .identity
                mark.alpha = 1
            }
        }
        
        //MARK: - Check cell noteIsFold
        if isFold == false {
            noteLabel.numberOfLines = 1
        } else {
            
            noteLabel.numberOfLines = 0
//            noteLabel.numberOfLines =  noteLabel.calculateMaxLines()
            
//            print("noteLabelLines:\(noteLabel.numberOfLines)")
        }
        
    }
    
//    func getAmountLineCell() -> Int {
//        let amountLineCell = noteLabel.calculateMaxLines()
//        return amountLineCell
//    }
    

}






//MARK: - Count amount line In Label
extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}

