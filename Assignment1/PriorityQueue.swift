//
//  PriorityQueue.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/2/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class PriorityQueue<Element: Hashable>: Collection {
    
    var heap: [Association<Double, Element>]
    
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
    
    init(students: [Association<Double, Element>] = []) {
        self.heap = students
        createHeap()
    }
    
    func peek() -> Element? {
        return heap.first?.value
    }
    
    // TODO return index of next element in priority order
    func index(after i: Int) -> Int {
        return i+1
    }
    
    // TODO Rename to removeAll?
    func clear(){
        heap.removeAll()
    }

    // TODO: Return association or key or value?
    subscript(position: Int) -> Association<Double, Element>? {
//        precondition(indices.contains(position), "out of bounds")
        guard indices.contains(position) else { return nil }
//        let dictionaryElement = heap[position]
        return heap[position]
//        return (element: dictionaryElement.key, count: dictionaryElement.value)
    }
    
    func getHighestPriority() -> Element? {
        return heap.first?.value
    }
    
    func isRoot(index: Int) -> Bool {
        return index == 0
    }
    
    func getLeftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    func getRightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    func getParentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return heap[firstIndex].key > heap[secondIndex].key
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
    
    func add(element: Element, priority: Double) {
        let association = Association(key: priority, value: element)
        add(association: association)
    }
    
    func add(association: Association<Double, Element>){
        heap.append(association)
        moveUp(studentAtIndex: count - 1) // Move the new student into its correct position
    }
    
    /// Takes a newly added student from its bottom position and moves it up to its appropriate priority position. Recursive function repeats until student is located at correct index.
    func moveUp(studentAtIndex index: Int) {
        let parent = getParentIndex(of: index)
        if isRoot(index: index) || !isHigherPriority(at: index, than: parent) { return } // Stops recursive calling
        swapElement(at: index, with: parent)
        moveUp(studentAtIndex: parent)
    }
    
    /// Remove and return the student with highest priority
    func removeHighest() -> Element? {
        if heap.isEmpty { return nil }
        swapElement(at: 0, with: count - 1) // Swap highest priority student with last student in the heap
        let student = heap.removeLast().value
        moveDown(studentAtIndex: 0) // Move the newly placed first student into its correct position
        return student
    }
    
    /// Create the heap given the students provided at initialization time.
    func createHeap() {
        // Move all parent elements down to their correct positionss
        for index in (0 ..< count / 2).reversed() {
            moveDown(studentAtIndex: index)
        }
    }
    
    /// Moves a low priority student from the top of the heap down to its correct priority position. Recursive function repeats until student is located at correct index.
    func moveDown(studentAtIndex index: Int) {
        guard count > 0 else { return }
        if let childIndex = highestPriorityIndex(for: index){
            if index == childIndex { return } // Stops recursive calling
            swapElement(at: index, with: childIndex)
            moveDown(studentAtIndex: childIndex)
        }
    }
    
    /// Swap positions in the heap of the first index with the second index.
    func swapElement(at firstIndex: Int, with secondIndex: Int) {
        heap.swapAt(firstIndex, secondIndex)
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
}
