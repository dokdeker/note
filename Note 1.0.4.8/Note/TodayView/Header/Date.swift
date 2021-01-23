//
//  Date.swift
//  Note
//
//  Created by Евгений on 22.12.2020.
//

import UIKit

extension TodayViewController {
    // MARK: - Check date for Header
    func checkDate() {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
//        let dayOfWeak = calendar.component(.calendar, from: date)
        
        
        
        func getTodayWeekDay()-> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "eeee"
            let weekDay = dateFormatter.string(from: Date())
            
            var literDayWeek = String()
            switch weekDay {
            case "Monday":
                literDayWeek  = "Понедельник"
            case "Tuesday":
                literDayWeek  = "Вторник"
            case "Wednesday":
                literDayWeek  = "Среда"
            case "Thursday":
                literDayWeek  = "Четверг"
            case "Friday":
                literDayWeek  = "Пятница"
            case "Saturday":
                literDayWeek  = "Суббота"
            case "Sunday":
                literDayWeek  = "Воскресенье"
                
                
            default:
                break
            }
            
            
            
            return literDayWeek
            
        }
        
        let dayWeek:String = getTodayWeekDay()
        
        //        print(dayOfWeak)
        //        print(day)
        var literMonth = String()
        switch (month) {
        case 1:
            literMonth = "Января"
        case 2:
            literMonth = "Февраля"
        case 3:
            literMonth = "Марта"
        case 4:
            literMonth = "Апреля"
        case 5:
            literMonth = "Мая"
        case 6:
            literMonth = "Июня"
        case 7:
            literMonth = "Июля"
        case 8:
            literMonth = "Августа"
        case 9:
            literMonth = "Сентября"
        case 10:
            literMonth = "Октября"
        case 11:
            literMonth = "Ноября"
        case 12:
            literMonth = "Декабря"
        default:
            break
        }
        print(literMonth)
        currentLitDate = dayWeek + ", " + String(day) + " " + literMonth
        dateLabel.text = currentLitDate.uppercased()
    }
}
