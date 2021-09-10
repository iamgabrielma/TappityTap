//
//  Debugger.swift
//  TappityTap
//
//  Created by Gabriel Maldonado Almendra on 10/9/21.
//

import Foundation

class Debugger {
    
    static func debug(active: Bool, message: String?, item: Any?){
        if item == nil {
            return
        } else {
            if active == true {
                print("DEBUG: \(String(describing: message)): \(String(describing: item))")
            }
        }
    }
}
