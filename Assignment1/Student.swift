//
//  Student.swift
//  Assignment1
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct Student: Equatable {
    private(set) var name: String!
    private(set) var redID: String!
    private(set) var email: String!
    private(set) var unitsTaken: Int!
    private(set) var gpa: Double!
    private let unitsWeight = 0.7
    private let maxUnits = 150
    private let minUnits = 0
    private let gpaWeight = 0.3
    private let maxGPA = 4.0
    private let minGPA = 0.0
    
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
