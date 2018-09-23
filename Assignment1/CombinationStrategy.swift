//
//  CombinationStrategy.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/22/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class CombinationStrategy: Strategy {
    
    typealias Element = Student
    private(set) var priority: Double
    
    required init(element: Student) {
        priority = Double(element.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + element.gpa * Student.gpaWeight / Student.maxGPA
    }
}
