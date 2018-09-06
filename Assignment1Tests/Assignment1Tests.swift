//
//  Assignment1Tests.swift
//  Assignment1Tests
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import XCTest
@testable import Assignment1

class Assignment1Tests: XCTestCase {
    
    let testCount = 10000
    
    // Students to test with, in ascending priority order
    let student1: Student = Student(name: "Ryan", redId: "1230", email: "ryan@ryan.com", unitsTaken: 20, gpa: 0.7)!
    let student2: Student = Student(name: "Kelly", redId: "52903", email: "kelly@kelly.com", unitsTaken: 50, gpa: 1.1)!
    let student3: Student = Student(name: "Tim", redId: "123012", email: "tim@tim.com", unitsTaken: 80, gpa: 2.5)!
    let student4: Student = Student(name: "Eddie", redId: "5", email: "eddie@eddie.com", unitsTaken: 100, gpa: 3.2)!
    let student5: Student = Student(name: "Mark", redId: "81723", email: "mark@mark.com", unitsTaken: 120, gpa: 4.0)!
    
    // Priorities of the above students
    let priority1 = 14.21
    let priority2 = 35.33
    let priority3 = 56.75
    let priority4 = 70.96
    let priority5 = 85.2
    
    
    var priorityQueue: PriorityQueue!
    var currentID: Int = 1
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Make sure priorityQueue is nil before each test run configures it below.
        XCTAssertNil(priorityQueue)
        // Init the priority queue and start numbering RedIDs at 1
        priorityQueue = PriorityQueue()
        XCTAssertEqual(priorityQueue.count, 0)
        currentID = 1
        // Add provided amount of random students to the queue to test with
        addRandomStudents(count: testCount)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // Nullify priorityQueue and reset currentID to ensure values don't remain for future tests
        priorityQueue = nil
        currentID = 1
        super.tearDown()
    }
    
    /// Create count students with ascending redID numbers, names, and emails with random GPAs and units taken within the given ranges 0.0-4.0 and 0-150 respectively
    func addRandomStudents(count: Int) {
        for _ in 0..<count {
            let name = "Name_\(currentID)"
            let redID = "\(currentID)"
            let email = "\(name)@gmail.com"
            let unitsTaken = Int(arc4random_uniform(151))
            let gpa = (Double(arc4random()) / 0xFFFFFFFF) * 4.0
            if let student = Student(name: name, redId: redID, email: email, unitsTaken: unitsTaken, gpa: gpa){
                currentID += 1
                priorityQueue.add(student: student)
            }
        }
    }
    
    /// Test to ensure that the priority queue size grows when adding students
    func testAddGrowsQueue(){
        var heapCount = priorityQueue.count
        for _ in 0..<testCount {
            addRandomStudents(count: 1)
            XCTAssertEqual(heapCount + 1, priorityQueue.count)
            heapCount += 1
        }
    }
    
    /// Test to ensure that the priority queue size shrinks when removing students
    func testRemoveShrinksQueue(){
        var heapCount = priorityQueue.count
        for _ in 0..<priorityQueue.count {
            let _ = priorityQueue.removeHighest()
            XCTAssertEqual(heapCount - 1, priorityQueue.count)
            heapCount -= 1
        }
    }

    /// Test to verify that removing students always removes the highest priority first
    func testRemoveOrder(){
        var queue = [Double]()
        for i in 0..<priorityQueue.count {
            let student = priorityQueue.getHighestPriority()
            queue.append((student?.priority())!)
            if i > 0 {
                XCTAssertGreaterThanOrEqual(queue[i-1], queue[i])
            }
        }
    }
    
    /// Test to verify that code can return the correct highest priority element with random elements added in random priority order
    func testGetHighestElement() {
        var highest: Double = 0.0
        for i in 0..<priorityQueue.count {
            if priorityQueue.Heap[i].priority() > highest {
                highest = priorityQueue.Heap[i].priority()
            }
        }
        XCTAssertEqual(priorityQueue.getHighestPriority()?.priority(), highest)
    }
    
    /// Test to verify when elements are added in priority order that the priority queue prioritizes them correctly
    func testAddInOrerElements(){
        priorityQueue.clear()
        XCTAssertEqual(priorityQueue.count, 0)
        priorityQueue.add(student: student5)
        priorityQueue.add(student: student4)
        priorityQueue.add(student: student3)
        priorityQueue.add(student: student2)
        priorityQueue.add(student: student1)
        let dequeue1 = priorityQueue.removeHighest()
        let dequeue2 = priorityQueue.removeHighest()
        let dequeue3 = priorityQueue.removeHighest()
        let dequeue4 = priorityQueue.removeHighest()
        let dequeue5 = priorityQueue.removeHighest()
        
        XCTAssertEqual(dequeue1?.priority(), priority5)
        XCTAssertEqual(dequeue2?.priority(), priority4)
        XCTAssertEqual(dequeue3?.priority(), priority3)
        XCTAssertEqual(dequeue4?.priority(), priority2)
        XCTAssertEqual(dequeue5?.priority(), priority1)
    }
    
    /// Test to verify when elements are added in reverse priority order that the priority queue prioritizes them correctly
    func testAddReverseOrderElements(){
        priorityQueue.clear()
        XCTAssertEqual(priorityQueue.count, 0)
        priorityQueue.add(student: student1)
        priorityQueue.add(student: student2)
        priorityQueue.add(student: student3)
        priorityQueue.add(student: student4)
        priorityQueue.add(student: student5)
        let dequeue1 = priorityQueue.removeHighest()
        let dequeue2 = priorityQueue.removeHighest()
        let dequeue3 = priorityQueue.removeHighest()
        let dequeue4 = priorityQueue.removeHighest()
        let dequeue5 = priorityQueue.removeHighest()
        
        XCTAssertEqual(dequeue1?.priority(), priority5)
        XCTAssertEqual(dequeue2?.priority(), priority4)
        XCTAssertEqual(dequeue3?.priority(), priority3)
        XCTAssertEqual(dequeue4?.priority(), priority2)
        XCTAssertEqual(dequeue5?.priority(), priority1)
    }
    
    /// Test to verify when elements are added in random priority order that the priority queue prioritizes them correctly
    func testAddRandomOrderElements(){
        priorityQueue.clear()
        XCTAssertEqual(priorityQueue.count, 0)
        var students = [student1, student2, student3, student4, student5]
        for _ in 0..<students.count {
            let index = Int(arc4random_uniform(UInt32(students.count)))
            priorityQueue.add(student: students[index])
            students.remove(at: index)
            print(index)
        }
        let dequeue1 = priorityQueue.removeHighest()
        let dequeue2 = priorityQueue.removeHighest()
        let dequeue3 = priorityQueue.removeHighest()
        let dequeue4 = priorityQueue.removeHighest()
        let dequeue5 = priorityQueue.removeHighest()
        XCTAssertEqual(dequeue1?.priority(), priority5)
        XCTAssertEqual(dequeue2?.priority(), priority4)
        XCTAssertEqual(dequeue3?.priority(), priority3)
        XCTAssertEqual(dequeue4?.priority(), priority2)
        XCTAssertEqual(dequeue5?.priority(), priority1)
    }
    
    /// Test to verify the root node has higher priority than both its children
    func testRootPriorityOverChildren() {
        XCTAssertEqual(priorityQueue.highestPriorityIndex(for: 0), 0)
    }
    
    /// Test to verify that removing from an empty queue return nil
    func testRemoveEmptyQueue() {
        priorityQueue.clear()
        XCTAssertEqual(priorityQueue.count, 0)
        let dequeuedStudent = priorityQueue.removeHighest()
        XCTAssertNil(dequeuedStudent)
    }
    
    /// Verify that all students in the priority queue have between 0 and 150 units taken
    func testValidUnitsTaken(){
        for student in priorityQueue.Heap {
            XCTAssertLessThanOrEqual(student.unitsTaken, 150)
            XCTAssertGreaterThanOrEqual(student.unitsTaken, 0)
        }
    }
    
    /// Verify that all students in the priority queue have between a 0.0 and 4.0 GPA
    func testValidGPA(){
        for student in priorityQueue.Heap {
            XCTAssertLessThanOrEqual(student.gpa, 4.0)
            XCTAssertGreaterThanOrEqual(student.gpa, 0.0)
        }
    }
    
    /// Verify that you cannot add a student with a GPA outside of 0.0 to 4.0
    func testInvalidGPA(){
        for i in 0..<testCount {
            let gpa: Double
            if i % 2 == 0 {
                // Creates a random number between 4.001 and max possible value
                gpa = Double(arc4random()) / Double(UInt32.max) * abs(4.001 - Double(UInt32.max)) + min(4.001, Double(UInt32.max))
            } else {
                // Creates a random number between -0.001 and min possible value
                gpa = -1 * Double(arc4random()) / Double(UInt32.max) * abs(0.001 - Double(UInt32.max)) + min(0.1, Double(UInt32.max))
            }
            let student = Student(name: "Gary", redId: "12492", email: "gary@gary.com", unitsTaken: 48, gpa: gpa)
            XCTAssertNil(student)
        }
        
    }
    
    /// Verify that you cannot add a student with a units taken outside of 0 to 150
    func testInvalidUnitsTaken(){
        for i in 0..<testCount {
            let units: Int
            if i % 2 == 0 {
                // Creates a random number between 151 and max possible value
                units = Int(arc4random_uniform(UInt32.max - 151)) + 151
            } else {
                // Creates a random number between -1 and min possible value
                units = -1 * Int(arc4random_uniform(UInt32.max - 1)) + 1
            }
            let student = Student(name: "Gary", redId: "12492", email: "gary@gary.com", unitsTaken: units, gpa: 0.5)
            XCTAssertNil(student)
        }
    }
    
    /// Test to see if the order students were printed in is the correct priority order.
    func testPrintQueueInOrder(){
        let students = priorityQueue.printQueue()
        guard var previousPriority = students.first?.priority() else { return }
        for student in students {
            XCTAssertGreaterThanOrEqual(previousPriority, student.priority())
            previousPriority = student.priority()
        }
    }
}
