//
//  RemoveCommand.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/23/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class RemoveCommand<Element: Equatable, S: Strategy>: Command where Element == S.Element{
    
    var priorityQueue: PriorityQueue<Element, S>
    var element: Element?
    
    init(priorityQueue: PriorityQueue<Element, S>) {
        self.priorityQueue = priorityQueue
    }
    
    func execute() {
        element = priorityQueue.dequeue()
    }
    
    func undo(){
        guard let unwrappedElement = element else { return }
        priorityQueue.enqueue(unwrappedElement)
    }
}
