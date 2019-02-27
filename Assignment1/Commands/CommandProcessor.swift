//
//  CommandProcessor.swift
//  Assignment1
//
//  Created by Mark Rassamni on 9/23/18.
//  Copyright © 2018 Mark Rassamni. All rights reserved.
//

import Foundation

class CommandProcessor {
    
    private(set) var pastStack = [Command]()
    private(set) var futureStack = [Command]()
    
    func execute(command: Command){
        command.execute()
        pastStack.append(command)
        futureStack = [Command]()
    }
    
    func undo(){
        guard pastStack.count > 0 else { return }
        let command = pastStack.removeLast()
        command.undo()
        futureStack.append(command)
    }
    
    func redo(){
        guard futureStack.count > 0 else { return }
        let command = futureStack.removeLast()
        command.execute()
        pastStack.append(command)
    }
}
