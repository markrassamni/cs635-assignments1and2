//
//  Strategy.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/22/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Strategy {
    associatedtype Element
    var priority: Double { get }
    func calculatePriority(element: Element) -> Double
    
    
}
