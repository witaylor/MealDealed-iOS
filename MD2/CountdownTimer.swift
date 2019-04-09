//
//  CountdownTimer.swift
//  MD2
//
//  Created by Will Taylor on 14/03/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class CountdownTimer {
    
    var targetHour   = 22
    var targetMinute = 00
    var timer: Timer!
    
    var label: UILabel!
    var timeResult: DateComponents!
    
    init(label: UILabel) {
        self.label = label
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    func calcTimeRemaining() -> DateComponents {
        let now = Date()
        let calendar = Calendar.current
        let components = DateComponents(calendar: calendar, hour: targetHour, minute: targetMinute)
        let nextTarget = calendar.nextDate(after: now, matching: components, matchingPolicy: .nextTime)!
        
        let diff = calendar.dateComponents([.hour, .minute, .second], from: now, to: nextTarget)
        
        return diff
    }
    
    @objc func fireTimer() {
        timeResult = calcTimeRemaining()
        
        let hourStr = timeResult.hour ?? 0   < 10 ? "0\(timeResult.hour ?? 0)"   : "\(timeResult.hour ?? 0)"
        let minStr  = timeResult.minute ?? 0 < 10 ? "0\(timeResult.minute ?? 0)" : "\(timeResult.minute ?? 0)"
        let secStr  = timeResult.second ?? 0 < 10 ? "0\(timeResult.second ?? 0)" : "\(timeResult.second ?? 0)"
        
        label.text = "\(hourStr):\(minStr):\(secStr)"
    }
}
