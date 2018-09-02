//
//  Heap.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct Heap {
    
    var queue: [Student]
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    var count: Int {
        return queue.count
    }
    
    func getHighestPriority() -> Student? {
        return queue.first
    }
    
    func isRoot(index: Int) -> Bool {
        return index == 0
    }
    
    func leftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    func rightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return queue[firstIndex].priority() > queue[secondIndex].priority()
    }
    
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        if childIndex < count && isHigherPriority(at: childIndex, than: parentIndex) {
            return childIndex
        }
        return parentIndex
    }
    
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        if firstIndex == secondIndex { return }
        queue.swapAt(firstIndex, secondIndex)
    }
    
    mutating func enqueue(student: Student) {
        queue.append(student)
        shiftUp(elementAtIndex: count - 1)
    }
    
    mutating func shiftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index)
        if isRoot(index: index) || !isHigherPriority(at: index, than: parent){ return }
        swapElement(at: index, with: parent)
        
        // Recursivley call self until sorted into position
        shiftUp(elementAtIndex: parent)
    }
    
    mutating func dequeue() -> Student? {
        if isEmpty { return nil }
        swapElement(at: 0, with: count - 1)
        let element = queue.removeLast()
        if !isEmpty {
            shiftDown(elementAtIndex: 0)
        }
        return element
    }
    
    mutating func shiftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex { return }
        swapElement(at: index, with: childIndex)
        shiftDown(elementAtIndex: childIndex)
    }
    
    init(students: [Student] = []) {
        self.queue = students
        buildHeap()
    }
    
    mutating func buildHeap() {
        for index in (0 ..< count / 2).reversed() {
            shiftDown(elementAtIndex: index)
        }
    }
    
}
