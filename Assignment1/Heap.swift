//
//  Heap.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/21/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation


class Heap<Element, S: Strategy>: Collection where S.Element == Element {
    
    private(set) var nodes = [Association<Double, Element>]()
    private(set) var priorityStrategy: S
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    var count: Int {
        return nodes.count
    }
    
    // TODO start and end index based on priority? or just of heap?
    var startIndex: Int {
        return nodes.startIndex
    }
    
    var endIndex: Int {
        return nodes.endIndex
    }
    
    init(strategy: S) {
        self.priorityStrategy = strategy
    }
    
    // TODO return index of next element in priority order
    func index(after i: Int) -> Int {
        return i+1
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
    
    // TODO: Test. Why does this return an element but PQ gets back an association
    func peek() -> Element? {
        return nodes.first?.value
    }
    
    // TODO test this function. PQ is passing in a association not an element
    func add(_ element: Element){
        let value = priorityStrategy.priority(element: element)
        let association = Association(key: value, value: element)
        nodes.append(association)
        moveUp(nodeAtIndex: count - 1)
    }
    
    /// Takes a newly added node from its bottom position and moves it up to its appropriate priority position. Recursive function repeats until node is located at correct index.
    func moveUp(nodeAtIndex index: Int) {
        let parentIndex = self.parentIndex(of: index)
        if isRoot(index: index) || !isHigherPriority(at: index, than: parentIndex) { return } // Stops recursive calling
        swapElement(at: index, with: parentIndex)
        moveUp(nodeAtIndex: parentIndex)
    }
    
    /// Remove and return the node with the highest priority
    func remove() -> Element?{
        if isEmpty { return nil }
        if count == 1 {
            return nodes.removeLast().value
        }
        swapElement(at: 0, with: count - 1) // Swap highest priority node with last node in the heap
        let node = nodes.removeLast().value
        moveDown(nodeAtIndex: 0) // Move the newly placed first node into its correct position
        return node
    }
    
    /// Moves a low priority student from the top of the heap down to its correct priority position. Recursive function repeats until student is located at correct index.
    func moveDown(nodeAtIndex index: Int) {
        guard count > 0 else { return }
        if let childIndex = highestPriorityIndex(for: index){
            if index == childIndex { return } // Stops recursive calling
            swapElement(at: index, with: childIndex)
            moveDown(nodeAtIndex: childIndex)
        }
    }
    
    /// Swap positions in the heap of the first index with the second index.
    func swapElement(at firstIndex: Int, with secondIndex: Int) {
        nodes.swapAt(firstIndex, secondIndex)
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return nodes[firstIndex].key > nodes[secondIndex].key
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
        if let leftChildParentMaxPriority = highestPriorityIndex(of: leftChildIndex(of: parent), and: parent){
            // Get highest priority between the left child, right child, and parent
            let highestPriority = highestPriorityIndex(of: leftChildParentMaxPriority, and: rightChildIndex(of: parent))
            return highestPriority
        }
        return nil
    }
    
//     TODO: Implement function
//    func toArray() -> [Element]{
//        var nodesAsArray: [Element]
//        for node in nodes {
//            let val = node.value
//            nodesAsArray.append(val)
////            if let element = node.value as? Element {
////                nodesAsArray.append(element)
////            }
//        }
//        return nodesAsArray
//    }
    
    // TODO: Implement function
    // https://docs.oracle.com/javase/7/docs/api/java/util/AbstractCollection.html#toString()
    // TODO: Can I just do "[\(toArray())]" - does it add commas?
    func toString() -> String{
        guard count > 0 else { return "[]" }
        var stringRepresentation = "["
        for (index, element) in nodes.enumerated() {
            if index < count - 1{
                stringRepresentation.append("\(element), ")
            } else {
                stringRepresentation.append("\(element)]")
            }
        }
        return stringRepresentation
    }
    
    // TODO: Should return priority order not just position in array.
    // Also, should return just element, or association?
    subscript(position: Int) -> Association<Double, Element> {
        return nodes[position]
    }
}
