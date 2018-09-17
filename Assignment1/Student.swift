//
//  Student.swift
//  Assignment1
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct Student: Equatable {
    var name: String
    var redID: String
    var email: String
    var unitsTaken: Int
    var gpa: Double
    
    func priority() -> Double {
        return Double(unitsTaken) * 0.7 + gpa * 0.3
    }
    
    init?(name: String, redId: String, email: String, unitsTaken: Int, gpa: Double) {
        // Check for valid units taken and gpa to intialize, otherwise fail to init
        var validParameters = true
        if unitsTaken < 0 || unitsTaken > 150 {
            validParameters = false
        }
        if gpa < 0.0 || gpa > 4.0 {
            validParameters = false
        }
        guard validParameters else { return nil }
        
        self.name = name
        self.redID = redId
        self.email = email
        self.unitsTaken = unitsTaken
        self.gpa = gpa
    }
}
