//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 8/28/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation


class PriorityQueue{
    
    private var queue: [Student]!
    
    func add(newStudent: Student){
        
        // If queue is empty, just add student to it
        if queue == nil {
            queue = [newStudent]
            return
        }
        let newStudentPriority = newStudent.priority()
        
        // Binary search to find correct placement in O(logN)
        var high = queue.count - 1
        var low = 0
        while low <= high {
            var middle = (low + high) / 2
            if queue[middle].priority() < newStudentPriority {
                high = middle - 1
            } else if queue[middle].priority() > newStudentPriority {
                low = middle + 1
            } else if queue[middle].priority() == newStudentPriority {
                queue.insert(newStudent, at: middle)
                break
            }
        }
        
        //        for (index, student) in queue.enumerated() {
        //            if newStudentPriority >= student.priority() {
        //                queue.insert(newStudent, at: index)
        //                break
        //            }
        //        }
    }
    
    // First element is highest priority
    func first() -> Student? {
        //TODO can queue be nil?
        
        if queue == nil || queue.count <= 0 { return nil }
        return queue.first!
    }
    
    func removeFirst() -> Student? {
        if let studentToRemove = first() {
            queue.removeFirst()
            return studentToRemove
        } else {
            return nil
        }
    }
    
    func printQueue(){
        for student in queue {
            print("Red ID: \(student.redId). Name: \(student.name)")
        }
    }
}
