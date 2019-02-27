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
}

extension Association: Equatable where K: Equatable, V: Equatable{
    static func == (lhs: Association<K, V>, rhs: Association<K, V>) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}
