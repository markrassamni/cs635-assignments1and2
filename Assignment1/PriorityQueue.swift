//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct PriorityQueue {
    
    var heap: [Student]
    
    /// Check if the heap is empty
    var isEmpty: Bool {
        return heap.isEmpty
    }
    
    /// Return how many elements are in the heap
    var count: Int {
        return heap.count
    }
    
    /// Return the student with the highest priority.
    /// If the heap is empty, return nil.
    func getHighestPriority() -> Student? {
        return heap.first
    }
    
    /// A boolean value indicating if index is the root node of the heap.
    func isRoot(index: Int) -> Bool {
        return index == 0
    }
    
    /// Given a parent index, get the index of the left child node.
    func leftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    /// Given a parent index, get the index of the right child node.
    func rightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    /// Given the index of a child, return the parent index.
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    /// Return a boolean indicating if the node at the first index is higher priority than the second index node.
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return heap[firstIndex].priority() > heap[secondIndex].priority()
    }
    
    /// Returns the index with higher priority between the parent and child indices.
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        if childIndex < count && isHigherPriority(at: childIndex, than: parentIndex) {
            return childIndex
        }
        return parentIndex
    }
    
    /// Returns the index of the highest priority element of a parent and its children.
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    /// Swap positions in the heap of the first index with the second index.
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        if firstIndex == secondIndex { return }
        heap.swapAt(firstIndex, secondIndex)
    }
    
    init(students: [Student] = []) {
        self.heap = students
        buildHeap()
    }
    
    mutating func buildHeap() {
        for index in (0 ..< count / 2).reversed() {
            shiftDown(elementAtIndex: index)
        }
    }
    
    /// Add a new element to the heap
    mutating func enqueue(student: Student) {
        heap.append(student)
        shiftUp(elementAtIndex: count - 1)
    }
    
    
    /// Takes a newly added student from its bottom position and moves it up to its appropriate priority position. Recursive function repeats until student is located at correct index.
    mutating func shiftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index)
        if isRoot(index: index) || !isHigherPriority(at: index, than: parent){ return }
        swapElement(at: index, with: parent)
        shiftUp(elementAtIndex: parent)
    }
    
    /// Remove the element with highest priority
    mutating func dequeue() -> Student? {
        if isEmpty { return nil }
        swapElement(at: 0, with: count - 1)
        let element = heap.removeLast()
        if !isEmpty {
            shiftDown(elementAtIndex: 0)
        }
        return element
    }
    
    /// Moves a low priority student from the top of the heap down to its correct priority position. Recursive function repeats until student is located at correct index.
    mutating func shiftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex { return }
        swapElement(at: index, with: childIndex)
        shiftDown(elementAtIndex: childIndex)
    }
    
    /// Prints the name and red ID of all students in the heap in priority order.
    func printQueue(){
        //TODO need to print in order, not like this
        for student in heap {
            print("Red ID: \(student.redId). Name: \(student.name)")
        }
    }
    
}
