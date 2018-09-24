//
//  AddCommand.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/23/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class AddCommand<Element: Equatable>: Command {
    
    var priorityQueue: PriorityQueue<Element>
    var element: Element
    
    init(priorityQueue: PriorityQueue<Element>, element: Element) {
        self.priorityQueue = priorityQueue
        self.element = element
    }
    
    func execute() {
        // TODO: Store a heap of everything under the foundPosition. Make a copy first, then enqueue in original, find its index in original
        /*
        guard let copyBeforeEnqueue = priorityQueue.copy(), let heapWithElementRoot = Heap<Element>(priorityStrategy: priorityQueue.priorityStrategy) else { return }
        priorityQueue.enqueue(element)
        let positionShiftedTo = priorityQueue.indices.filter { priorityQueue[$0] == element }[0]
        
        // Now make a new heap using all elements under position as root parent

        heapWithElementRoot.add(copyBeforeEnqueue[positionShiftedTo])
        
        // count = min int of 2^h+1 -1
        // 2^h+1 = count + 1
        
        
        /*
        let index = priorityQueue.count + 1
        let parentIndex = priorityQueue.heap.parentIndex(of: index)
        let parent = priorityQueue[parentIndex]
        
        var foundPosition = false
        
        // TODO: be able to unsort back to previous state, need to know how many times it was moved up. Maybe store directions it came from? enum left right child?
        while !foundPosition {
            if priorityQueue.priorityStrategy(element) < priorityQueue.priorityStrategy(parent) {
                foundPosition = true
                
                
                break
            }
        }
        */
         // This was sole existing command in previous func
        priorityQueue.enqueue(element)
 
         */
        priorityQueue.enqueue(element)
    }
    
    func undo(){
        let _ = priorityQueue.remove(element: element)
    }
}
