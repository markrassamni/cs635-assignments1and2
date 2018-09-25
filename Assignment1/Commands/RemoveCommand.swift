//
//  RemoveCommand.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/23/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class RemoveCommand<Element: Equatable>: Command {
    
    var priorityQueue: PriorityQueue<Element>
    var element: Element?
    
    init(priorityQueue: PriorityQueue<Element>) {
        self.priorityQueue = priorityQueue
    }
    
    func execute() {
        element = priorityQueue.dequeue()
        priorityQueue.heap.moveDown(nodeAtIndex: 1)
        
        
        // CHANGING HERE
        
        let minStrat = { (priority1: Double, priority2: Double) -> Bool in
            priority1 < priority2
        }
        
        let priority1 = priorityQueue.priorityStrategy(priorityQueue[0])
        let priority2 = priorityQueue.priorityStrategy(priorityQueue[1])
        
        let a = minStrat(priority1, priority2)
        
        
        
//        if priorityQueue.comparatorStrategy == a) {
//            
//        }
        
    }
    
    func undo(){
        guard let unwrappedElement = element else { return }
        priorityQueue.enqueue(unwrappedElement)
    }
}
