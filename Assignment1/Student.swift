//
//  Student.swift
//  Assignment1
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct Student: Equatable {
    var name: String!
    var redID: String!
    var email: String!
    var unitsTaken: Int!
    var gpa: Double!
    
    let unitsWeight = 0.7
    let maxUnits = 150
    let minUnits = 0
    let gpaWeight = 0.3
    let maxGPA = 4.0
    let minGPA = 0.0
    
    // TODO do not hard code in priority function to all students
    func priority() -> Double {
        return Double(unitsTaken) * unitsWeight / Double(maxUnits) + gpa * gpaWeight / maxGPA
    }
    
    init?(name: String, redId: String, email: String, unitsTaken: Int, gpa: Double) {
        guard unitsTaken >= minUnits && unitsTaken <= maxUnits && gpa >= minGPA && gpa <= maxGPA else {
            return nil
        }
        self.name = name
        self.redID = redId
        self.email = email
        self.unitsTaken = unitsTaken
        self.gpa = gpa
    }
}
