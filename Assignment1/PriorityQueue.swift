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
    
    var first: Element? {
        return heap.first
    }
    
    init(priorityStrategy: S){
        heap = Heap<Element, S>(strategy: priorityStrategy)
    }
    
    func index(after i: Int) -> Int {
        return heap.index(after: i)
    }
    
    func enqueue(_ element: Element){
        heap.add(element)
    }
    
    func dequeue() -> Element? {
        return heap.remove()
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
