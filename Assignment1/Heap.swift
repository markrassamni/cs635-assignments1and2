//
//  Heap.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/21/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation


class Heap<Element: Equatable>: Collection, CustomStringConvertible {
    
    private(set) var nodes = [Association<Double, Element>]()
    private(set) var priorityStrategy: (Element) -> Double
    private(set) var comparatorStrategy: (Double, Double) -> Bool
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    var count: Int {
        return nodes.count
    }
    
    var first: Element?{
        return nodes.first?.value
    }
    
    var startIndex: Int {
        return nodes.startIndex
    }
    
    var endIndex: Int {
        return nodes.endIndex
    }
    
    // Swift version of Java toString()
    var description: String {
        guard count > 0 else { return "[]" }
        var stringRepresentation = "["
        for (index, element) in nodes.enumerated() {
            if index < count - 1{
                stringRepresentation.append("\(element.value), ")
            } else {
                stringRepresentation.append("\(element.value)]")
            }
        }
        return stringRepresentation
    }

    /// priorityStrategy is a function used to calculate priority
    /// comparatorStrategy parameter defaults to max heap but can be passed a closure for min heap
    init?<T: Equatable>(priorityStrategy: @escaping (T) -> Double, comparatorStrategy: @escaping (Double, Double) -> Bool = (>)) {
        guard let strategy = priorityStrategy as? (Element) -> Double else { return nil }
        self.priorityStrategy = strategy
        self.comparatorStrategy = comparatorStrategy
    }
    
    func index(after i: Int) -> Int {
        return nodes.index(after: i)
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
    
    func add(_ element: Element){
        let priority = priorityStrategy(element)
        let association = Association(key: priority, value: element)
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
    
    func removeFirst() -> Element?{
        if isEmpty { return nil }
        if count == 1 {
            return nodes.removeLast().value
        }
        swapElement(at: 0, with: count - 1)
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
        return comparatorStrategy(nodes[firstIndex].key, nodes[secondIndex].key)
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
        if let leftChildParentMaxPriority = highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)){
            // Get highest priority between the left child, right child, and parent
            let highestPriority = highestPriorityIndex(of: leftChildParentMaxPriority, and: rightChildIndex(of: parent))
            return highestPriority
        }
        return nil
    }
    
    func toArray() -> [Element]{
        var nodesAsArray = [Element]()
        for node in nodes {
            nodesAsArray.append(node.value)
        }
        return nodesAsArray
    }
    
    func remove(element: Element) -> Element? {
        if let index = index(of: element){
            swapElement(at: index, with: count - 1)
            let removedElement = nodes.removeLast().value
            if index < count {
                moveUp(nodeAtIndex: index)
                moveDown(nodeAtIndex: index)
            }
            return removedElement
        }
        return nil
    }
    
    func makeIterator() -> AnySequence<Element> {
        return AnySequence<Element> { () -> AnyIterator<Element> in
            var index = 0
            return AnyIterator {
                let element = self.nodes[index].value
                index += 1
                return element
            }
        }
    }
    
    func index(of element: Element) -> Int?{
        for (index, node) in nodes.enumerated(){
            if node.value == element {
                return index
            }
        }
        return nil
    }

    subscript(position: Int) -> Element {
        return nodes[position].value
    }
}

extension Heap: Equatable {
    static func == (lhs: Heap<Element>, rhs: Heap<Element>) -> Bool {
        let sort = { (association1: Association<Double, Element>, association2: Association<Double, Element>) -> Bool in
            association1.key > association2.key
        }        
        return lhs.first == rhs.first && lhs.count == rhs.count && lhs.nodes.sorted(by: sort) == rhs.nodes.sorted(by: sort)
    }
}
