//
//  AppDelegate.swift
//  Latencer
//
//  Created by Sai Vittal B on 20/05/2020.
//  Copyright © 2020 Sai Vittal B. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var app: Latency!
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        UserDefaults.standard.register(defaults: [
            "ipaddress": "8.8.8.8",
            "interval": 0.5
        ])
        app.swiftyPing();
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
 
}
