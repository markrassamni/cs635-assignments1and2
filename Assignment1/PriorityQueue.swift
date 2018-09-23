//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class PriorityQueue<Element, S: Strategy>: Collection where S.Element == Element {
    
    private(set) var heap: Heap<Element, S>
    
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
        heap = Heap<Element, S>(strategy: priorityStrategy)
    }
    
    func index(after i: Int) -> Int {
        return heap.index(after: i)
    }
    
    func peek() -> Element? {
        return heap.peek()?.value
    }
    
    func enqueue(_ element: Element){
        // Weird compile error if just passing an element to heap.add(). Must pass association with dummy priority.
        let association = Association(key: 0.0, value: element)
        heap.add(association)
    }
    
    func dequeue() -> Element? {
        return heap.remove()?.value
    }
    
    // TODO: Implement toArray
//    func toArray() -> [Element] {
//        return heap.toArray()
//    }
    
    func toString() -> String {
        return heap.toString()
    }
    
    subscript(position: Int) -> Element {
        return heap[position].value
    }
}
