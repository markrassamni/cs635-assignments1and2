//
//  Assignment1Tests.swift
//  Assignment1Tests
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import XCTest
@testable import Assignment1

class Assignment1Tests: XCTestCase{

    let testCount = 10000
    
    // Students to test with, in ascending priority order
    let student1: Student = Student(name: "Ryan", redId: "1230", email: "ryan@ryan.com", unitsTaken: 20, gpa: 0.7)!
    let student2: Student = Student(name: "Kelly", redId: "52903", email: "kelly@kelly.com", unitsTaken: 50, gpa: 1.1)!
    let student3: Student = Student(name: "Tim", redId: "123012", email: "tim@tim.com", unitsTaken: 80, gpa: 2.5)!
    let student4: Student = Student(name: "Eddie", redId: "5", email: "eddie@eddie.com", unitsTaken: 100, gpa: 3.2)!
    let student5: Student = Student(name: "Mark", redId: "81723", email: "mark@mark.com", unitsTaken: 120, gpa: 4.0)!
    
    // Respective priorities to the above students
    let combinationPriority1 = 0.1458
    let combinationPriority2 = 0.3158
    let combinationPriority3 = 0.5608
    let combinationPriority4 = 0.7066
    let combinationPriority5 = 0.86
    
    let gpaPriority1 = 0.7
    let gpaPriority2 = 1.1
    let gpaPriority3 = 2.5
    let gpaPriority4 = 3.2
    let gpaPriority5 = 4.0
    
    let unitsPriority1 = 20.0
    let unitsPriority2 = 50.0
    let unitsPriority3 = 80.0
    let unitsPriority4 = 100.0
    let unitsPriority5 = 120.0
    
    
    // TODO: Move weights to here instead of in student class?
    let combinationStrategy = { (student: Student) -> Double in
        Double(student.unitsTaken) * Student.unitsWeight / Double(Student.maxUnits) + student.gpa * Student.gpaWeight / Student.maxGPA
    }
    let gpaStrategy = { (student: Student) -> Double in
        student.gpa
    }
    let unitsStrategy = { (student: Student) -> Double in
        Double(student.unitsTaken)
    }
    
    var combinationPriorityQueue: PriorityQueue<Student>!
    var gpaPriorityQueue: PriorityQueue<Student>!
    var unitsPriorityQueue: PriorityQueue<Student>!
    var currentID: Int = 1
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Make sure priority queues are nil before each test run configures them below.
        XCTAssertNil(combinationPriorityQueue)
        XCTAssertNil(gpaPriorityQueue)
        XCTAssertNil(unitsPriorityQueue)
        // Init the priority queues and start numbering RedIDs at 1
        combinationPriorityQueue = PriorityQueue(priorityStrategy: combinationStrategy)
        gpaPriorityQueue = PriorityQueue(priorityStrategy: gpaStrategy)
        unitsPriorityQueue = PriorityQueue(priorityStrategy: unitsStrategy)
        XCTAssertNotNil(combinationPriorityQueue)
        XCTAssertNotNil(gpaPriorityQueue)
        XCTAssertNotNil(unitsPriorityQueue)
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        XCTAssertEqual(gpaPriorityQueue.count, 0)
        XCTAssertEqual(unitsPriorityQueue.count, 0)
        currentID = 1
        // Add provided amount of random students to the queues to test with
        addRandomStudents(count: testCount)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // Nullify priority queues and reset currentID to ensure values don't remain for future tests
        combinationPriorityQueue = nil
        gpaPriorityQueue = nil
        unitsPriorityQueue = nil
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
                combinationPriorityQueue.enqueue(student)
                gpaPriorityQueue.enqueue(student)
                unitsPriorityQueue.enqueue(student)
            }
        }
    }
    
    /*
    func testGetPriority(){
        let p = priority(for: student1, with: GPAStrategy() as! S)
        print(p)
    }
    
    func priority(for student: Student, with strategy: S) -> Double {
        return 2.0
        
        
    }
 */
    
    /// Test to ensure that the priority queue sizes grow when adding students
    func testAddGrowsQueue(){
        var combinationCount = combinationPriorityQueue.count
        var gpaCount = gpaPriorityQueue.count
        var unitsCount = gpaPriorityQueue.count
        for _ in 0..<testCount {
            addRandomStudents(count: 1)
            XCTAssertEqual(combinationCount + 1, combinationPriorityQueue.count)
            XCTAssertEqual(gpaCount + 1, gpaPriorityQueue.count)
            XCTAssertEqual(unitsCount + 1, unitsPriorityQueue.count)
            combinationCount += 1
            gpaCount += 1
            unitsCount += 1
        }
    }
    
    /// Test to ensure that the priority queue size shrinks when removing students
    func testRemoveShrinksQueue(){
        var combinationCount = combinationPriorityQueue.count
        var gpaCount = gpaPriorityQueue.count
        var unitsCount = gpaPriorityQueue.count
        let maxCount = max(combinationCount, max(gpaCount, unitsCount))
        for _ in 0..<maxCount {
            let combinationStudent = combinationPriorityQueue.dequeue()
            let gpaStudent = gpaPriorityQueue.dequeue()
            let unitsStudent = unitsPriorityQueue.dequeue()
            XCTAssertEqual(combinationCount - 1, combinationPriorityQueue.count)
            XCTAssertEqual(gpaCount - 1, gpaPriorityQueue.count)
            XCTAssertEqual(unitsCount - 1, unitsPriorityQueue.count)
            if combinationStudent != nil {
                combinationCount -= 1
            }
            if gpaStudent != nil {
                gpaCount -= 1
            }
            if unitsStudent != nil {
                unitsCount -= 1
            }
        }
    }
    
    //MARK: - Tests to verify that removing students always removes the highest priority first
    func testRemoveOrderCombination(){
        var queue = [Double]()
        for i in 0..<combinationPriorityQueue.count {
            if let student = combinationPriorityQueue.dequeue() {
                let priority = combinationStrategy(student)
                queue.append(priority)
                if i > 0 {
                    XCTAssertGreaterThanOrEqual(queue[i-1], queue[i])
                }
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testRemoveOrderGPA(){
        var queue = [Double]()
        for i in 0..<gpaPriorityQueue.count {
            if let student = gpaPriorityQueue.dequeue() {
                let priority = gpaStrategy(student)
                queue.append(priority)
                if i > 0 {
                    XCTAssertGreaterThanOrEqual(queue[i-1], queue[i])
                }
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testRemoveOrderUnits(){
        var queue = [Double]()
        for i in 0..<unitsPriorityQueue.count {
            if let student = unitsPriorityQueue.dequeue() {
                let priority = unitsStrategy(student)
                queue.append(priority)
                if i > 0 {
                    XCTAssertGreaterThanOrEqual(queue[i-1], queue[i])
                }
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    
    
    //MARK: - Tests to verify that code can return the correct highest priority element with random elements added in random priority order
    func testGetHighestElementCombination() {
        var highestPriority: Double = 0.0
        for i in 0..<combinationPriorityQueue.count {
            if combinationPriorityQueue.heap[i].key > highestPriority {
                highestPriority = combinationPriorityQueue.heap[i].key
            }
        }
        if let dequeuedStudent = combinationPriorityQueue.dequeue() {
            let dequeuedPriority = combinationStrategy(dequeuedStudent)
            XCTAssertEqual(dequeuedPriority, highestPriority)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testGetHighestElementGPA() {
        var highestPriority: Double = 0.0
        for i in 0..<gpaPriorityQueue.count {
            if gpaPriorityQueue.heap[i].key > highestPriority {
                highestPriority = gpaPriorityQueue.heap[i].key
            }
        }
        if let dequeuedStudent = gpaPriorityQueue.dequeue() {
            let dequeuedPriority = gpaStrategy(dequeuedStudent)
            XCTAssertEqual(dequeuedPriority, highestPriority)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testGetHighestElementUnits() {
        var highestPriority: Double = 0.0
        for i in 0..<unitsPriorityQueue.count {
            if unitsPriorityQueue.heap[i].key > highestPriority {
                highestPriority = unitsPriorityQueue.heap[i].key
            }
        }
        if let dequeuedStudent = unitsPriorityQueue.dequeue() {
            let dequeuedPriority = unitsStrategy(dequeuedStudent)
            XCTAssertEqual(dequeuedPriority, highestPriority)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    
    
    
    //MARK: - Tests to verify when elements are added in priority order that the priority queues prioritize them correctly
    func testAddInOrderElementsCombination(){
        // Create new PQ to clear all stored values to only use the 5 needed for testing
        combinationPriorityQueue = PriorityQueue(priorityStrategy: combinationStrategy)
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        
        combinationPriorityQueue.enqueue(student5)
        combinationPriorityQueue.enqueue(student4)
        combinationPriorityQueue.enqueue(student3)
        combinationPriorityQueue.enqueue(student2)
        combinationPriorityQueue.enqueue(student1)
        let dequeue1 = combinationPriorityQueue.dequeue()
        let dequeue2 = combinationPriorityQueue.dequeue()
        let dequeue3 = combinationPriorityQueue.dequeue()
        let dequeue4 = combinationPriorityQueue.dequeue()
        let dequeue5 = combinationPriorityQueue.dequeue()
        let priority1 = combinationStrategy(dequeue1!)
        let priority2 = combinationStrategy(dequeue2!)
        let priority3 = combinationStrategy(dequeue3!)
        let priority4 = combinationStrategy(dequeue4!)
        let priority5 = combinationStrategy(dequeue5!)
        
        XCTAssertEqual(priority1, combinationPriority5, accuracy: 0.0001)
        XCTAssertEqual(priority2, combinationPriority4, accuracy: 0.0001)
        XCTAssertEqual(priority3, combinationPriority3, accuracy: 0.0001)
        XCTAssertEqual(priority4, combinationPriority2, accuracy: 0.0001)
        XCTAssertEqual(priority5, combinationPriority1, accuracy: 0.0001)
    }
    
    func testAddInOrderElementsGPA(){
        // Create new PQ to clear all stored values to only use the 5 needed for testing
        gpaPriorityQueue = PriorityQueue(priorityStrategy: gpaStrategy)
        XCTAssertEqual(gpaPriorityQueue.count, 0)
        
        gpaPriorityQueue.enqueue(student5)
        gpaPriorityQueue.enqueue(student4)
        gpaPriorityQueue.enqueue(student3)
        gpaPriorityQueue.enqueue(student2)
        gpaPriorityQueue.enqueue(student1)
        let dequeue1 = gpaPriorityQueue.dequeue()
        let dequeue2 = gpaPriorityQueue.dequeue()
        let dequeue3 = gpaPriorityQueue.dequeue()
        let dequeue4 = gpaPriorityQueue.dequeue()
        let dequeue5 = gpaPriorityQueue.dequeue()
        let priority1 = gpaStrategy(dequeue1!)
        let priority2 = gpaStrategy(dequeue2!)
        let priority3 = gpaStrategy(dequeue3!)
        let priority4 = gpaStrategy(dequeue4!)
        let priority5 = gpaStrategy(dequeue5!)
        
        XCTAssertEqual(priority1, gpaPriority5, accuracy: 0.0001)
        XCTAssertEqual(priority2, gpaPriority4, accuracy: 0.0001)
        XCTAssertEqual(priority3, gpaPriority3, accuracy: 0.0001)
        XCTAssertEqual(priority4, gpaPriority2, accuracy: 0.0001)
        XCTAssertEqual(priority5, gpaPriority1, accuracy: 0.0001)
    }
    
    func testAddInOrderElementsUnits(){
        // Create new PQ to clear all stored values to only use the 5 needed for testing
        unitsPriorityQueue = PriorityQueue(priorityStrategy: unitsStrategy)
        XCTAssertEqual(unitsPriorityQueue.count, 0)
        
        unitsPriorityQueue.enqueue(student5)
        unitsPriorityQueue.enqueue(student4)
        unitsPriorityQueue.enqueue(student3)
        unitsPriorityQueue.enqueue(student2)
        unitsPriorityQueue.enqueue(student1)
        let dequeue1 = unitsPriorityQueue.dequeue()
        let dequeue2 = unitsPriorityQueue.dequeue()
        let dequeue3 = unitsPriorityQueue.dequeue()
        let dequeue4 = unitsPriorityQueue.dequeue()
        let dequeue5 = unitsPriorityQueue.dequeue()
        let priority1 = unitsStrategy(dequeue1!)
        let priority2 = unitsStrategy(dequeue2!)
        let priority3 = unitsStrategy(dequeue3!)
        let priority4 = unitsStrategy(dequeue4!)
        let priority5 = unitsStrategy(dequeue5!)
        
        XCTAssertEqual(priority1, unitsPriority5, accuracy: 0.0001)
        XCTAssertEqual(priority2, unitsPriority4, accuracy: 0.0001)
        XCTAssertEqual(priority3, unitsPriority3, accuracy: 0.0001)
        XCTAssertEqual(priority4, unitsPriority2, accuracy: 0.0001)
        XCTAssertEqual(priority5, unitsPriority1, accuracy: 0.0001)
    }
    
    
    // MARK: - Tests to verify when elements are added in reverse priority order that the priority queues prioritize them correctly
    func testAddReverseOrderElementsCombination(){
        // Create new PQ to clear all stored values to only use the 5 needed for testing
        combinationPriorityQueue = PriorityQueue(priorityStrategy: combinationStrategy)
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        combinationPriorityQueue.enqueue(student1)
        combinationPriorityQueue.enqueue(student2)
        combinationPriorityQueue.enqueue(student3)
        combinationPriorityQueue.enqueue(student4)
        combinationPriorityQueue.enqueue(student5)
        let dequeue1 = combinationPriorityQueue.dequeue()
        let dequeue2 = combinationPriorityQueue.dequeue()
        let dequeue3 = combinationPriorityQueue.dequeue()
        let dequeue4 = combinationPriorityQueue.dequeue()
        let dequeue5 = combinationPriorityQueue.dequeue()
        let priority1 = combinationStrategy(dequeue1!)
        let priority2 = combinationStrategy(dequeue2!)
        let priority3 = combinationStrategy(dequeue3!)
        let priority4 = combinationStrategy(dequeue4!)
        let priority5 = combinationStrategy(dequeue5!)
        
        XCTAssertEqual(priority1, combinationPriority5, accuracy: 0.0001)
        XCTAssertEqual(priority2, combinationPriority4, accuracy: 0.0001)
        XCTAssertEqual(priority3, combinationPriority3, accuracy: 0.0001)
        XCTAssertEqual(priority4, combinationPriority2, accuracy: 0.0001)
        XCTAssertEqual(priority5, combinationPriority1, accuracy: 0.0001)
    }
    
    func testAddReverseOrderElementsGPA(){
        // Create new PQ to clear all stored values to only use the 5 needed for testing
        gpaPriorityQueue = PriorityQueue(priorityStrategy: gpaStrategy)
        XCTAssertEqual(gpaPriorityQueue.count, 0)
        
        gpaPriorityQueue.enqueue(student1)
        gpaPriorityQueue.enqueue(student2)
        gpaPriorityQueue.enqueue(student3)
        gpaPriorityQueue.enqueue(student4)
        gpaPriorityQueue.enqueue(student5)
        let dequeue1 = gpaPriorityQueue.dequeue()
        let dequeue2 = gpaPriorityQueue.dequeue()
        let dequeue3 = gpaPriorityQueue.dequeue()
        let dequeue4 = gpaPriorityQueue.dequeue()
        let dequeue5 = gpaPriorityQueue.dequeue()
        let priority1 = gpaStrategy(dequeue1!)
        let priority2 = gpaStrategy(dequeue2!)
        let priority3 = gpaStrategy(dequeue3!)
        let priority4 = gpaStrategy(dequeue4!)
        let priority5 = gpaStrategy(dequeue5!)
        
        XCTAssertEqual(priority1, gpaPriority5, accuracy: 0.0001)
        XCTAssertEqual(priority2, gpaPriority4, accuracy: 0.0001)
        XCTAssertEqual(priority3, gpaPriority3, accuracy: 0.0001)
        XCTAssertEqual(priority4, gpaPriority2, accuracy: 0.0001)
        XCTAssertEqual(priority5, gpaPriority1, accuracy: 0.0001)
    }
    
    func testAddReverseOrderElementsUnits(){
        // Create new PQ to clear all stored values to only use the 5 needed for testing
        unitsPriorityQueue = PriorityQueue(priorityStrategy: unitsStrategy)
        XCTAssertEqual(unitsPriorityQueue.count, 0)
        
        unitsPriorityQueue.enqueue(student1)
        unitsPriorityQueue.enqueue(student2)
        unitsPriorityQueue.enqueue(student3)
        unitsPriorityQueue.enqueue(student4)
        unitsPriorityQueue.enqueue(student5)
        let dequeue1 = unitsPriorityQueue.dequeue()
        let dequeue2 = unitsPriorityQueue.dequeue()
        let dequeue3 = unitsPriorityQueue.dequeue()
        let dequeue4 = unitsPriorityQueue.dequeue()
        let dequeue5 = unitsPriorityQueue.dequeue()
        let priority1 = unitsStrategy(dequeue1!)
        let priority2 = unitsStrategy(dequeue2!)
        let priority3 = unitsStrategy(dequeue3!)
        let priority4 = unitsStrategy(dequeue4!)
        let priority5 = unitsStrategy(dequeue5!)
        
        XCTAssertEqual(priority1, unitsPriority5, accuracy: 0.0001)
        XCTAssertEqual(priority2, unitsPriority4, accuracy: 0.0001)
        XCTAssertEqual(priority3, unitsPriority3, accuracy: 0.0001)
        XCTAssertEqual(priority4, unitsPriority2, accuracy: 0.0001)
        XCTAssertEqual(priority5, unitsPriority1, accuracy: 0.0001)
    }
    
    
    /*
    /// Test to verify when elements are added in random priority order that the priority queue prioritizes them correctly
    func testAddRandomOrderElements(){
        priorityQueue.removeAll()
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        var students = [student1, student2, student3, student4, student5]
        for _ in 0..<students.count {
            let index = Int(arc4random_uniform(UInt32(students.count)))
            priorityQueue.add(element: students[index], priority: students[index].priority)
            students.remove(at: index)
        }
        let dequeue1 = priorityQueue.removeHighest()
        let dequeue2 = priorityQueue.removeHighest()
        let dequeue3 = priorityQueue.removeHighest()
        let dequeue4 = priorityQueue.removeHighest()
        let dequeue5 = priorityQueue.removeHighest()
        XCTAssertEqual((dequeue1?.priority)!, priority5, accuracy: 0.0001)
        XCTAssertEqual((dequeue2?.priority)!, priority4, accuracy: 0.0001)
        XCTAssertEqual((dequeue3?.priority)!, priority3, accuracy: 0.0001)
        XCTAssertEqual((dequeue4?.priority)!, priority2, accuracy: 0.0001)
        XCTAssertEqual((dequeue5?.priority)!, priority1, accuracy: 0.0001)
    }
    
    /// Test to verify the root node has higher priority than both its children
    func testRootPriorityOverChildren() {
        XCTAssertEqual(priorityQueue.highestPriorityIndex(for: 0), 0)
    }
    
    /// Test to verify that removing from an empty queue return nil
    func testRemoveEmptyQueue() {
        priorityQueue.removeAll()
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        let dequeuedStudent = priorityQueue.removeHighest()
        XCTAssertNil(dequeuedStudent)
    }
    
    func testAddToEmptyQueue() {
        priorityQueue.removeAll()
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        priorityQueue.add(element: student3, priority: student3.priority)
        XCTAssertEqual(combinationPriorityQueue.count, 1)
        XCTAssertEqual(combinationPriorityQueue.heap[0].value, student3)
    }
    
    /// Verify that all students in the priority queue have between 0 and 150 units taken
    func testValidUnitsTaken(){
        for student in combinationPriorityQueue.heap {
            XCTAssertLessThanOrEqual(student.value.unitsTaken, 150)
            XCTAssertGreaterThanOrEqual(student.value.unitsTaken, 0)
        }
    }
    
    /// Verify that all students in the priority queue have between a 0.0 and 4.0 GPA
    func testValidGPA(){
        for student in combinationPriorityQueue.heap {
            XCTAssertLessThanOrEqual(student.value.gpa, 4.0)
            XCTAssertGreaterThanOrEqual(student.value.gpa, 0.0)
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
    
    // TODO recreate print method, not inside priority queue class
    /// Test to see if the order students were printed in is the correct priority order.
//    func testPrintQueueInOrder(){
//        let students = priorityQueue.printQueue()
//        guard var previousPriority = students.first?.priority() else { return }
//        for student in students {
//            XCTAssertGreaterThanOrEqual(previousPriority, student.priority())
//            previousPriority = student.priority()
//        }
//    }
 */
}

