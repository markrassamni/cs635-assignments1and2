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
        
        let copy = priorityQueue.copy()
        
        
        
        
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
        
        priorityQueue.enqueue(element)
 
         */
    }
    
    func undo(){
        let _ = priorityQueue.remove(element: element)
    }
}
