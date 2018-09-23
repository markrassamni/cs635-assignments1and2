//
//  Command.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/23/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

protocol Command{
    func execute()
    func undo()
}
