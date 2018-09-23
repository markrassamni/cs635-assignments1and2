//
//  StudentStrategy.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/22/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation


class StudentStrategy: Strategy {
    private(set) var priority: Double
    
    typealias Element = Student
    
    func oldP(strategy: (Element) -> Double) {
        
    }
    
    func test2(){
         let student: Student = Student(name: "Ryan", redId: "1230", email: "ryan@ryan.com", unitsTaken: 20, gpa: 0.7)!
        let strat = StudentStrategy(element: student)
        let p = PriorityQueue<Student, StudentStrategy>(priorityStrategy: strat)
//        let o = PriorityQueue(priorityStrategy: strat)
    }
    
    func calculatePriority(element: Student) -> Double {
        return Double(element.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + element.gpa * Student.gpaWeight / Student.maxGPA
    }
    
    init(element: Element) {
        priority = Double(element.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + element.gpa * Student.gpaWeight / Student.maxGPA
    }
    
    func priority(for student: (Student) -> Double) {
//        priority. = value
    }
    
    func newP(priorityFunction: (Student) -> Double) {
        
    }
    
    func test(){
        let student: Student = Student(name: "Ryan", redId: "1230", email: "ryan@ryan.com", unitsTaken: 20, gpa: 0.7)!
//        let f = priority { (student) -> Double in
//            return Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA
//        }
//        let a = f(student)
        
        let closure: (Student) -> Double = { (student) in
            return Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA
        }
        
        let b = closure(student)
        print(b)
        newP(priorityFunction: closure)
        
        
    }
    
//    func funcName({ (Student) -> Double in
//
//    })
    
}
