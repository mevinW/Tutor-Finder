//
//  Appointment.swift
//  Final Project
//
//  Created by Rohan Annapragada (student LM) on 4/29/24.
//

import Foundation


class Appointment: ObservableObject, Identifiable{
    var ID  = UUID()
    @Published var startTime : Date
    @Published var duration: Int
    @Published var name: String
    
    
    var endTime : Date{
        return startTime.addingTimeInterval(TimeInterval(duration * 60))
    }
    
    
    init(name: String = ":3", startTime: Date = Date(), duration: Int = 60) {
        self.name = name
        self.startTime = startTime
        self.duration = duration
    }
    
}



