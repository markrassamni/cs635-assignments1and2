//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class PriorityQueue<Element>: Collection {
    
    private(set) var heap: Heap<Element>
    
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
    
    init(){
        heap = Heap<Element>()
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
