//
//  Association.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/17/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class Association <K, V> {
    
    private(set) var key: K
    private(set) var value: V
    
    init(key: K, value: V) {
        self.key = key
        self.value = value
    }
    
//    init(element: V, strategy: Strategy) {
//        self.value = v
//        self.key = strategy.priority
//    }
}
