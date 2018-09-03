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
    var redId: String
    var email: String
    var unitsTaken: Int
    var gpa: Double
    
    func priority() -> Double {
        //TODO: is this how to determine priority?
        return Double(unitsTaken) * 0.7 + gpa * 0.3
    }
}

//extension Student: Equatable {
//    static func ==(lhs: Student, rhs: Student) -> Bool {
//        return lhs.name == rhs.name && lhs.redId == rhs.redId && lhs.email == rhs.email && lhs.unitsTaken == rhs.unitsTaken && lhs.gpa == rhs.gpa
//    }
//}
