//
//  DatePickerTime.swift
//  Note
//
//  Created by Евгений on 30.12.2020.
//

import UIKit

var timeButtonIsActive = Bool()
var timeSettingsIsShow:Bool = false

extension NoteViewController  {
    
    //MARK: Logic
    func timeButtonAction(isActive: Bool) {
        
        if isActive == true {
            
            timeSettingsIsShow = true
//            timeButtonOutlet.isSelected = false
            timeView.isHidden = false
            
            fadeInTimeView()
            
            
        } else if isActive == false {
            
            timeSettingsIsShow = false
//            timeButtonOutlet.isSelected = false
            
            fadeOutTimeView()
        }
    }
    
    
    
    
    
    
    func checkTimeButtonActive() {
        if startTimeSwitcherOutlet.isOn == true || endTimeSwitcherOutlet.isOn == true {
            
            timeButtonOutlet.setImage(UIImage(systemName: "clock.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
//            timeButtonOutlet.backgroundColor = .systemGray
//            timeButtonOutlet.layer.cornerRadius = 4
            timeButtonOutlet.tintColor = .systemBlue
            
            timeButtonIsActive = true
            
        } else  {
            timeButtonOutlet.setImage(UIImage(systemName: "clock",withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)),for: .normal)
//            timeButtonOutlet.backgroundColor = .none
            timeButtonOutlet.tintColor = .systemGray
            
            
            timeButtonIsActive = false
        }
    }
    
    
    
    func checkTimeActive() {
        if Note.startTime != ""{
            startTimeSwitcherOutlet.isOn = true
        } else {
            startTimeSwitcherOutlet.isOn = false
        }
        
        if Note.endTime != ""{
            endTimeSwitcherOutlet.isOn = true
        } else {
            endTimeSwitcherOutlet.isOn = false
        }
        
        checkTimeButtonActive()
    }
    
    //MARK: - Button action
    @IBAction func timeButtonAction(_ sender: UIButton) {
        print(timeButtonIsActive)
        startTimePickerOutlet.preferredDatePickerStyle = .inline
        endTimePickerOutlet.preferredDatePickerStyle = .inline
        view.layoutIfNeeded()
        if timeSettingsIsShow == false {
            timeButtonAction(isActive: true)
        } else {
            timeButtonAction(isActive: false)
        }
    }
    //MARK:  Switcher action
    @IBAction func startTimePickerChangeValueAction(_ sender: Any) {
        getTimeFromTimePicker()
        print(Note.startTime)
    }
    
    
    @IBAction func endTimePickerChangeValueAction(_ sender: Any) {
        getTimeFromTimePicker()
        print(Note.endTime)
    }
    
    @IBAction func startTimeSwitcher(_ sender: Any) {
        if startTimeSwitcherOutlet.isOn == true {
            startTimeLabel.alpha = 1
            startTimePickerOutlet.alpha = 1
            startTimePickerOutlet.isEnabled = true
            getTimeFromTimePicker()
            checkTimeButtonActive()
        }
        
        if startTimeSwitcherOutlet.isOn == false {
            startTimeLabel.alpha = 0.5
            startTimePickerOutlet.alpha = 0.5
            startTimePickerOutlet.isEnabled = false
            Note.startTime = ""
            checkTimeButtonActive()
        }
    }
    
    @IBAction func endTimeSwitcher(_ sender: Any) {
        if endTimeSwitcherOutlet.isOn == true {
            endTimeLabel.alpha = 1
            endTimePickerOutlet.alpha = 1
            endTimePickerOutlet.isEnabled = true
            getTimeFromTimePicker()
            checkTimeButtonActive()
        }
        
        if endTimeSwitcherOutlet.isOn == false {
            endTimeLabel.alpha = 0.5
            endTimePickerOutlet.alpha = 0.5
            endTimePickerOutlet.isEnabled = false
            Note.endTime = ""
            checkTimeButtonActive()
        }
    }
    
    

    
    //MARK: - Transfer time (from/to)
    func getTimeFromTimePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if startTimeSwitcherOutlet.isOn == true {
            Note.startTime = formatter.string(from: startTimePickerOutlet.date)
        }
        
        if endTimeSwitcherOutlet.isOn == true {
            Note.endTime = formatter.string(from: endTimePickerOutlet.date)
        }
    }
    
    func giveTimeToTimePickerFromUsedCell() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        //print("startTimeFormated \(Note.startTime)")
        if Note.startTime != ""{
            startTimePickerOutlet.date = formatter.date(from: Note.startTime)!
        } else {
            startTimeSwitcherOutlet.isOn = false
            startTimeLabel.alpha = 0.5
            startTimePickerOutlet.alpha = 0.5
            startTimePickerOutlet.isEnabled = false
        }
        
        if Note.endTime != "" {
            endTimePickerOutlet.date = formatter.date(from: Note.endTime)!
        } else {
            endTimeSwitcherOutlet.isOn = false
            endTimeLabel.alpha = 0.5
            endTimePickerOutlet.alpha = 0.5
            endTimePickerOutlet.isEnabled = false
        }
    }
    
    
    //MARK: - FadeIn/Out timeView
    func fadeInTimeView() {
        switch patternNoteView {
        
        case NoteStatus.create:
            
            UIView.animate(withDuration: 0.7, delay: 0,
                           usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: { [self] in
                            
                            timeView.alpha = 1
                            
                            headLabelTopConst.constant = 10
                            fromHeadToColorMarkBar.constant = 110
                            view.layoutIfNeeded()
                            
                           }) { [self] (completed) in
                
//                timeButtonOutlet.isSelected = true
            }
            
        case NoteStatus.edit:
            
            UIView.animate(withDuration: 0.7, delay: 0,
                           usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: { [self] in
                            
                            timeView.alpha = 1
                            
                            headLabelTopConst.constant = -17
                            fromHeadToColorMarkBar.constant = 100
                            view.layoutIfNeeded()
                            
                           }) { [self] (completed) in
                
//                timeButtonOutlet.isSelected = true
            }
        default:
            break
        }
    }
    
    func fadeOutTimeView() {
        switch patternNoteView {

        case NoteStatus.create:
            
            UIView.animate(withDuration: 0.7, delay: 0,
                           usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: { [self] in
                            timeView.alpha = 0
                            
                            headLabelTopConst.constant = 10
                            fromHeadToColorMarkBar.constant = 10
                            view.layoutIfNeeded()
                            
                           }) { [self] (completed) in
                
                timeView.isHidden = true
//                timeButtonOutlet.isSelected = true
            }
            
            
        case NoteStatus.edit:
            
            UIView.animate(withDuration: 0.7, delay: 0,
                           usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: { [self] in
                            timeView.alpha = 0
                            
                            headLabelTopConst.constant = -17
                            fromHeadToColorMarkBar.constant = 10
                            view.layoutIfNeeded()
                            
                           }) { [self] (completed) in
                
                timeView.isHidden = true
//                timeButtonOutlet.isSelected = true
            }
            
        default:
            break
        }
    }
    
}
