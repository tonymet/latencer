//
//  Latency.swift
//  Latencer
//
//  Created by Sai Vittal B on 20/05/2020.
//  Copyright © 2020 Sai Vittal B. All rights reserved.
//

import Cocoa

class Latency  :NSObject{
    let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength);
    @IBOutlet weak var userDefaults: NSUserDefaultsController!
    @IBOutlet var settingsWindow2: NSWindow!
    func run() {
        item.button?.title = "0";
        item.menu = createMenu();
        swiftyPing();
    }
    override init(){
        super.init();
        self.run();
    }
     func createMenu() -> NSMenu {
        let menu = NSMenu();
        
        let donate = NSMenuItem(title: "Donate", action: #selector(self.donate), keyEquivalent: "");
        donate.target = self;
        menu.addItem(donate);
        
        let separator = NSMenuItem.separator();
        menu.addItem(separator);
        
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(self.settings), keyEquivalent: ",")
        settingsItem.target=self;
        menu.addItem(settingsItem);
        
        menu.addItem(NSMenuItem.separator())
        let quit = NSMenuItem(title: "Quit", action: #selector(self.quit), keyEquivalent: "q");
        quit.target = self;
        menu.addItem(quit);
        
        return menu;
    }

    
    
    @objc  func donate() {
        let url = URL(string: "https://www.paypal.me/saivittalb33")!;
        NSWorkspace.shared.open(url);
    }
    
    @objc  func quit() {
        NSApplication.shared.terminate(nil);
    }
    
    @objc  func settings() {
        self.settingsWindow2.display();
    }
    
    func swiftyPing(){
        do{
            let ipAddress = UserDefaults.standard.string(forKey: "ipaddress");
            let pinger = try SwiftyPing(host: ipAddress!, configuration: PingConfiguration(interval: 0.5, with: 5), queue: DispatchQueue.global())
            pinger.observer = { (response) in
                let duration = response.duration
                print(duration)
                self.item.button?.title = String(format: "%0.2f", duration * 1000);
            }
            pinger.startPinging();
        }
        catch {
            print("Error Swiftyping");
        }
    }
}
