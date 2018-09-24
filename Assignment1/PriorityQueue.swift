//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class PriorityQueue<Element: Equatable>: Collection, IteratorProtocol, CustomStringConvertible {
    
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
    
    var first: Element? {
        return heap.first
    }
    
    var priorityStrategy: (Element) -> Double {
        return heap.priorityStrategy
    }
    
    var comparatorStrategy: (Double, Double) -> Bool {
        return heap.comparatorStrategy
    }
    
    // Swift version of Java toString()
    var description: String {
        return heap.description
    }
    
    init?<T: Equatable>(priorityStrategy: @escaping (T) -> Double, comparatorStrategy: @escaping (Double, Double) -> Bool = (>)){
        guard let heap = Heap<Element>(priorityStrategy: priorityStrategy, comparatorStrategy: comparatorStrategy) else { return nil }
        self.heap = heap
    }
    
    func index(after i: Int) -> Int {
        return heap.index(after: i)
    }
    
    func enqueue(_ element: Element){
        heap.add(element)
    }
    
    func dequeue() -> Element? {
        return heap.removeFirst()
    }
    
    func toArray() -> [Element] {
        return heap.toArray()
    }
    
    func remove(element: Element) -> Element?{
        return heap.remove(element: element)
    }
    
    func next() -> Element? {
        return heap.next()
    }
    
    subscript(position: Int) -> Element {
        return heap[position]
    }
}

extension PriorityQueue: Equatable {
    static func == (lhs: PriorityQueue<Element>, rhs: PriorityQueue<Element>) -> Bool {
        return lhs.heap == rhs.heap
    }
}
