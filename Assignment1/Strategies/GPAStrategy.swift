//
//  GPAStrategy.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/22/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class GPAStrategy: Strategy {
    
    typealias Element = Student
    
    func priority(element: Student) -> Double {
        return element.gpa
    }
}
