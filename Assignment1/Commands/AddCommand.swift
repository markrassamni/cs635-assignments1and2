//
//  AddCommand.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/23/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class AddCommand<Element: Equatable, S: Strategy>: Command where Element == S.Element{
    
    var priorityQueue: PriorityQueue<Element, S>
    var element: Element
    
    init(priorityQueue: PriorityQueue<Element, S>, element: Element) {
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
