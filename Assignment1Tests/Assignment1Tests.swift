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
    
    let gpaPriority1 = 4.0
    let gpaPriority2 = 3.2
    let gpaPriority3 = 2.5
    let gpaPriority4 = 1.1
    let gpaPriority5 = 0.7
    
    let unitsPriority1 = 120
    let unitsPriority2 = 100
    let unitsPriority3 = 80
    let unitsPriority4 = 50
    let unitsPriority5 = 20
    
    
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
//                gpaPriorityQueue.enqueue(student)
//                unitsPriorityQueue.enqueue(student)
            }
        }
    }
    /*
    /*
    func testGetPriority(){
        let p = priority(for: student1, with: GPAStrategy() as! S)
        print(p)
    }
    
    func priority(for student: Student, with strategy: S) -> Double {
        return 2.0
        
        
    }
 */
    
    /// Test to ensure that the priority queue size grows when adding students
    func testAddGrowsQueue(){
        var heapCount = combinationPriorityQueue.count
        for _ in 0..<testCount {
            addRandomStudents(count: 1)
            XCTAssertEqual(heapCount + 1, combinationPriorityQueue.count)
            heapCount += 1
        }
    }
    
    /// Test to ensure that the priority queue size shrinks when removing students
    func testRemoveShrinksQueue(){
        var heapCount = combinationPriorityQueue.count
        for _ in 0..<combinationPriorityQueue.count {
            let _ = combinationPriorityQueue.dequeue()
            XCTAssertEqual(heapCount - 1, combinationPriorityQueue.count)
            heapCount -= 1
        }
    }
    
    //MARK: - Tests to verify that removing students always removes the highest priority first
    // TODO: Check Wiki and see if we can just return association and do association.key to get priority for all of the below tests
    func testRemoveOrderCombination(){
        var queue = [Double]()
        for i in 0..<combinationPriorityQueue.count {
            if let student = combinationPriorityQueue.dequeue() {
                let priority = CombinationStrategy().priority(element: student)
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
                let priority = GPAStrategy().priority(element: student)
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
                let priority = UnitsStrategy().priority(element: student)
                queue.append(priority)
                if i > 0 {
                    XCTAssertGreaterThanOrEqual(queue[i-1], queue[i])
                }
            } else {
                XCTAssertTrue(false)
            }
        }
    }
    
    
    /*
    /// Test to verify that code can return the correct highest priority element with random elements added in random priority order
    func testGetHighestElement() {
        var highest: Double = 0.0
        for i in 0..<combinationPriorityQueue.count {
            if combinationPriorityQueue.heap[i].key > highest {
                highest = combinationPriorityQueue.heap[i].key
            }
        }
        XCTAssertEqual(priorityQueue.getHighestPriority()?.priority, highest)
    }
    
    /// Test to verify when elements are added in priority order that the priority queue prioritizes them correctly
    func testAddInOrderElements(){
        priorityQueue.removeAll()
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        priorityQueue.add(element: student5, priority: student5.priority)
        priorityQueue.add(element: student4, priority: student4.priority)
        priorityQueue.add(element: student3, priority: student3.priority)
        priorityQueue.add(element: student2, priority: student2.priority)
        priorityQueue.add(element: student1, priority: student1.priority)
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
    
    /// Test to verify when elements are added in reverse priority order that the priority queue prioritizes them correctly
    func testAddReverseOrderElements(){
        priorityQueue.removeAll()
        XCTAssertEqual(combinationPriorityQueue.count, 0)
        priorityQueue.add(element: student1, priority: student1.priority)
        priorityQueue.add(element: student2, priority: student2.priority)
        priorityQueue.add(element: student3, priority: student3.priority)
        priorityQueue.add(element: student4, priority: student4.priority)
        priorityQueue.add(element: student5, priority: student5.priority)
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
 */
}

