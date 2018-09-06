//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

struct PriorityQueue {
    
    private var heap: [Student]
    
    var Heap: [Student] {
        get {
            return heap
        }
    }
    
    /// Return how many elements are in the heap
    var count: Int {
        return heap.count
    }
    
    /// Initialize the priority queue with the given students. If no students provided, create an empty heap.
    init(students: [Student] = []) {
        self.heap = students
        createHeap()
    }
    
    /// Remove all of the elements from the heap
    mutating func clear(){
        heap = [Student]()
    }
    
    /// Return the student with the highest priority. If the heap is empty, return nil.
    func getHighestPriority() -> Student? {
        return heap.first
    }
    
    /// A boolean value indicating if index is the root node of the heap.
    func isRoot(index: Int) -> Bool {
        return index == 0
    }
    
    /// Given a parent index, get the index of the left child node.
    func getLeftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    /// Given a parent index, get the index of the right child node.
    func getRightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    /// Given the index of a child, return the parent index.
    func getParentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    /// Return a boolean indicating if the node at the first index is higher priority than the second index node.
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return heap[firstIndex].priority() > heap[secondIndex].priority()
    }
    
    /// Returns the index with higher priority between the parent and child indices. Returns nil if the parent index is not contained in the heap.
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int? {
        guard parentIndex < count else { return nil }
        if childIndex < count && isHigherPriority(at: childIndex, than: parentIndex) {
            return childIndex
        }
        return parentIndex
    }
    
    /// Returns the index of the highest priority element of a parent and its children. Returns nil if the parent index is outside of heap bounds.
    func highestPriorityIndex(for parent: Int) -> Int? {
        guard parent < count else { return nil }
        // Get highest priority between the left child and parent
        if let leftChildParentMaxPriority = highestPriorityIndex(of: getLeftChildIndex(of: parent), and: parent){
            // Get highest priority between the left child, right child, and parent
            let highestPriority = highestPriorityIndex(of: leftChildParentMaxPriority, and: getRightChildIndex(of: parent))
            return highestPriority
        }
        return nil
    }
    
    /// Add a new element to the heap
    mutating func add(student: Student) {
        heap.append(student)
        moveUp(studentAtIndex: count - 1) // Move the new student into its correct position
    }
    
    /// Takes a newly added student from its bottom position and moves it up to its appropriate priority position. Recursive function repeats until student is located at correct index.
    mutating func moveUp(studentAtIndex index: Int) {
        let parent = getParentIndex(of: index)
        if isRoot(index: index) || !isHigherPriority(at: index, than: parent) { return } // Stops recursive calling
        swapElement(at: index, with: parent)
        moveUp(studentAtIndex: parent)
    }
    
    /// Remove and return the student with highest priority
    mutating func removeHighest() -> Student? {
        if heap.isEmpty { return nil }
        swapElement(at: 0, with: count - 1) // Swap highest priority student with last student in the heap
        let student = heap.removeLast()
        moveDown(studentAtIndex: 0) // Move the newly placed first student into its correct position
        return student
    }
    
    /// Create the heap given the students provided at initialization time.
    mutating func createHeap() {
        // Move all parent elements down to their correct positionss
        for index in (0 ..< count / 2).reversed() {
            moveDown(studentAtIndex: index)
        }
    }
    
    /// Moves a low priority student from the top of the heap down to its correct priority position. Recursive function repeats until student is located at correct index.
    mutating func moveDown(studentAtIndex index: Int) {
        guard count > 0 else { return }
        if let childIndex = highestPriorityIndex(for: index){
            if index == childIndex { return } // Stops recursive calling
            swapElement(at: index, with: childIndex)
            moveDown(studentAtIndex: childIndex)
        }
    }
    
    /// Swap positions in the heap of the first index with the second index.
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        heap.swapAt(firstIndex, secondIndex)
    }
    
    /// Prints the name and red ID of all students in the heap in priority order.
    func printQueue(){
        //TODO need to print in order, not like this
        for student in heap {
            print("Red ID: \(student.redId). Name: \(student.name)")
        }
    }
    
}
