//
//  WaiterLaunch.swift
//  Territorios
//
//  Created by Jose Blanco on 1/2/23.
//

import Foundation


class WaiterLaunch {
    
    private var delayed: Int
    private var request = 0
    private var timer: Timer? = nil
    private var onFinished: () -> Void
    
    init(delay: Int = 5, onFinish: @escaping () -> Void) {
        onFinished = onFinish
        delayed = delay
    }
    
    
    func enterRequest() {
        request += 1
        startTimer()
    }
    
    func leaveRequest() {
        request -= 1
    }
    
    
    private func startTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: Double(delayed), repeats: true, block: { ti in
            if self.onTimer() {
                ti.invalidate()
            }
        })
    }
    
    private func onTimer() -> Bool {
        if request == 0 {
            onFinished()
            return true
        }
        return false
    }
    
}
