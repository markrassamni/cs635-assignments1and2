//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class PriorityQueue<Element, S: Strategy>: Collection {
    
    private(set) var heap: Heap<Element>
//    private(set) var priorityFunction: (Element) -> Double
//    private(set) var priorityFunction: (Element, Element) -> Bool
    private(set) var priorityStrategy: S
    
    var isEmpty: Bool {
        return heap.isEmpty
    }
    
    var count: Int {
        return heap.count
    }

    var startIndex: Int {
        return heap.startIndex
    }
    
    var endIndex: Int {
        return heap.endIndex
    }
    
    init(priorityStrategy: S){
        heap = Heap<Element>()
        self.priorityStrategy = priorityStrategy
    }
    
//    init(strategy2: @escaping (Element, Element) -> Bool){
//        heap = Heap<Element>()
//        priorityFunction = strategy2
//    }
    
//    func test5(){
//        let p = PriorityQueue(strategy2: >)
//        let student1 = Student(name: "name", redId: "redID", email: "email", unitsTaken: 101, gpa: 2.7)!
//        let student2 = Student(name: "name", redId: "redID", email: "email", unitsTaken: 101, gpa: 2.7)!
//        priorityFunction(student1, student2)
//    }
    
//    init(strategy1: @escaping (Element) -> Double) {
//        heap = Heap<Element>()
//        priorityFunction = strategy1
//
//        let student = Student(name: "name", redId: "redID", email: "email", unitsTaken: 101, gpa: 2.7)!
//        if let element = student as? Element {
//            let studentPriority = priorityFunction(element)
//        }
//
//    }
    
    
//    func test4(){
//        let student = Student(name: "name", redId: "redID", email: "email", unitsTaken: 101, gpa: 2.7)!
//        let o = PriorityQueue { (priority) -> Double in
//            return 4.0
//        }
//        if let element = student as? Element {
////            let studentPriority = priorityFunction(element)
//            let b = o.priorityFunction(element)
//        }
//
//        if let element2 = student as? Element {
//            let closure: (Student) -> Double = { (student) in
//                return Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA
//            }
//            let closure2: (Student) -> Double = { student in
//                Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA }
////            let c = PriorityQueue(strategy1: closure2)
//        }
//
//        let closure: (Student) -> Double = { (student) in
//            return Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA
//        }
//
//
//    }
    
//    init(strategy: S) {
//        heap = Heap<Element>()
//        let student = Student(name: "name", redId: "redID", email: "email", unitsTaken: 101, gpa: 2.7)!
//        let b = StudentStrategy(element: student)
////        priorityFunction = strategy.calculatePriority(element: student)
//    }
    
//    func test3(){
//        let student = Student(name: "name", redId: "redID", email: "email", unitsTaken: 101, gpa: 2.7)!
//        let b = StudentStrategy(element: student)
////        test2(strategy: b)
//
//        let a = PriorityQueue { (testvar) -> Double in
//            if let student = testvar as? Element {
//
//            }
//            return 1
//        }
////        let b = testvar + 1
//    }
    
    func test2(strategy: S){
        
    }
    
    func test(){
        
        let closure: (Student) -> Double = { (student) in
            return Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA
        }
//        let p = PriorityQueue(strategy: closure)
        
        
//        let p = PriorityQueue { (student) -> Double in
//            return 3.0
//        }

//        let b = PriorityQueue { (Student) -> Double in
//            return Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA
            
//        }
    }

    subscript(position: Int) -> Element {
        return heap[position]
    }
    
    func index(after i: Int) -> Int {
        return heap.index(after: i)
    }
    
    func peek() -> Element? {
        return heap.peek()
    }
    
    func enqueue(_ element: Element){
        heap.add(element)
    }
    
    func dequeue() -> Element? {
        return heap.remove()
    }
    
    func toArray() -> [Element] {
        return heap.toArray()
    }
    
    func toString() -> String {
        return heap.toString()
    }
    
}


/*
 // TODO: Need to move this method outside of PQ class
 /// Prints the name and red ID of all students in the heap in priority order. Returns the students in a priority order sorted array.
 func printQueue() -> [Element]{
 // Create a copy of the original heap. Loop removing the highest priority and printing it. Restore heap when done.
 let heapCopy = heap
 var students = [Element]()
 for _ in heap { // TODO: Check if this function operates correctly
 if let student = removeHighest() {
 students.append(student)
 }
 }
 heap = heapCopy
 return students
 }
 */
