//
//  Student.swift
//  Assignment1
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct Student: Equatable {
    private var name: String
    private var redID: String
    private var email: String
    private var unitsTaken: Int
    private var gpa: Double
    
    var Name: String {
        get {
            return name
        }
    }
    
    var RedID: String {
        get {
            return redID
        }
    }
    
    var Email: String {
        get {
            return email
        }
    }
    
    var UnitsTaken: Int {
        get {
            return unitsTaken
        }
    }
    
    var GPA: Double {
        get {
            return gpa
        }
    }
    
    func priority() -> Double {
        return Double(unitsTaken) * 0.7 + gpa * 0.3
    }
    
    init?(name: String, redId: String, email: String, unitsTaken: Int, gpa: Double) {
        // Check for valid units taken and gpa to intialize, otherwise fail to init
        var validParameters = true
        if unitsTaken < 0 || unitsTaken > 150 {
            validParameters = false
            print("Units taken must be between 0 and 150")
        }
        if gpa < 0.0 || gpa > 4.0 {
            validParameters = false
            print("GPA must be between 0.0 and 4.0")
        }
        guard validParameters else { return nil }
        
        self.name = name
        self.redID = redId
        self.email = email
        self.unitsTaken = unitsTaken
        self.gpa = gpa
    }
}
