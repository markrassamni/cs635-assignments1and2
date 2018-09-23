//
//  Student.swift
//  Assignment1
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct Student: Equatable {
    private(set) var name: String
    private(set) var redID: String
    private(set) var email: String
    private(set) var unitsTaken: Int
    private(set) var gpa: Double
    static let unitsWeight = 0.7
    static let maxUnits = 150
    static let minUnits = 0
    static let gpaWeight = 0.3
    static let maxGPA = 4.0
    static let minGPA = 0.0
    
    // TODO do not hard code in priority function to all students?
    var priority: Double {
        return Double(unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + gpa * Student.gpaWeight / Student.maxGPA
    }
    
    init?(name: String, redId: String, email: String, unitsTaken: Int, gpa: Double) {
        guard unitsTaken >= Student.minUnits, unitsTaken <= Student.maxUnits, gpa >= Student.minGPA, gpa <= Student.maxGPA else {
            return nil
        }
        self.name = name
        self.redID = redId
        self.email = email
        self.unitsTaken = unitsTaken
        self.gpa = gpa
    }
}
