//
//  Student.swift
//  Assignment1
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct Student {
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
