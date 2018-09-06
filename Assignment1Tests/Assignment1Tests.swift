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
    
    let testElementCount = 100
    
    
    var priorityQueue: PriorityQueue!
    
    var currentID: Int!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        priorityQueue = PriorityQueue()
        currentID = 1

        enqueueRandomStudents(count: testElementCount)
    }
    

    
    func enqueueRandomStudents(count: Int) {
        for _ in 0..<count {
            let name = "Name \(currentID)"
            let redID = "\(currentID)"
            let email = "\(name)@gmail.com"
            let unitsTaken = Int(arc4random_uniform(151))
            let gpa = (Double(arc4random()) / 0xFFFFFFFF) * 4.0
            let student = Student(name: name, redId: redID, email: email, unitsTaken: unitsTaken, gpa: gpa)
            currentID! += 1
            priorityQueue.enqueue(student: student)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        priorityQueue = nil
        currentID = nil
        super.tearDown()
        
    }
    
    func testDequeueOrder(){
        var queue = [Double]()
        for i in 0..<priorityQueue.count {
            let student = priorityQueue.getHighestPriority()
            queue.append((student?.priority())!)
            if i > 0 {
                XCTAssertGreaterThanOrEqual(queue[i-1], queue[i])
            }
        }
    }
    
    func testGetHighestElement() {
        let shouldBeHighest = priorityQueue.getHighestPriority()?.priority()
        var actualHighest: Double = 0.0
        for i in 0..<priorityQueue.count {
            if priorityQueue.heap[i].priority() > actualHighest {
                actualHighest = priorityQueue.heap[i].priority()
            }
        }
        XCTAssertEqual(shouldBeHighest, actualHighest)
    }
    
    func testDequeuePerformance() {
        self.measure {
            let _ = priorityQueue.dequeue()
        }
    }
    
    func testEnqueuePerformance() {
        self.measure {
            enqueueRandomStudents(count: 1)
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
