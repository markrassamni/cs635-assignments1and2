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
        priorityQueue.enqueue(element)
    }
    
    func undo(){
        let _ = priorityQueue.remove(element: element)
    }
}
