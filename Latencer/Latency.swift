import Cocoa

class Latency  :NSObject{
    let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength);
    var pinger : SwiftyPing?
    @IBOutlet weak var taskMenu: NSMenu!
    @IBOutlet weak var userDefaults: NSUserDefaultsController!
    @IBOutlet var settingsWindow2: NSWindow!
   
    override func awakeFromNib() {
        let ipAddress = UserDefaults.standard.string(forKey: "ipaddress");
        let interval = UserDefaults.standard.double(forKey: "interval");
        self.pinger = try? SwiftyPing(host: ipAddress!, configuration: PingConfiguration(interval: interval, with: 5), queue: DispatchQueue.global())
        item.button?.title = "0";
        item.menu = taskMenu;
    }

    @IBAction func addressAction(_ sender: NSTextField) {
        let host = sender.stringValue;
        print("changing destionation host: ", host);
        if let result = try? SwiftyPing.Destination.getIPv4AddressFromHost(host: host){
            let destination = SwiftyPing.Destination(host: host, ipv4Address: result)
            pinger?.destination = destination;
        }
    }
    
    @IBAction func quitAction(_ sender: Any) {
        NSApplication.shared.terminate(nil);
    }
    
    @IBAction func settingsAction(_ sender: Any) {
        self.settingsWindow2.setIsVisible(true);
    }
    
    func swiftyPing(){
        pinger?.observer = { (response) in
            let duration = response.duration
            print(duration)
            self.item.button?.title = String(format: "%0.2f", duration * 1000);
        }
        pinger?.startPinging();
    }
}
