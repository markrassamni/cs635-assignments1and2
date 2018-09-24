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
    static let maxUnits = 150
    static let minUnits = 0
    static let maxGPA = 4.0
    static let minGPA = 0.0
    
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
