//
//  Connection.swift
//  MD2
//
//  Created by Will Taylor on 14/03/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

// Adapted from:
// https://www.hackingwithswift.com/example-code/networking/how-to-check-for-internet-connectivity-using-nwpathmonitor

import Foundation
import Network

class Connection {

    init() { self.monitorConnection() }
    
    private let monitor     = NWPathMonitor()
    private var isConnected = true
    
    private func monitorConnection() {
        print(" >> Checking connection!")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
                
                print(" >> We're connected!")
            } else {
                self.isConnected = false
                
                print(" >> No connection.")
            }
            
            print(path.isExpensive)
        }
    }
    
    func connected() -> Bool {
        return self.isConnected
    }
}
