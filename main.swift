import Cocoa
import OSLog

autoreleasepool {
    let app = NSApplication.shared
    
    // This causes the permission prompt to not appear and the app to hang when trying to access the pasteboard
    app.setActivationPolicy(.prohibited)
    
    let appDelegate = AppDelegate()
    app.delegate = appDelegate
    
    app.run()
}

class AppDelegate: NSObject, NSApplicationDelegate {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Pasteboard")
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        logger.notice("Trying to get string from pasteboard...")
        
        // With `app.setActivationPolicy(.prohibited)` the app hangs here
        // Even without setting the activation policy to prohibited, an error message is printed:
        // ERROR: Setting <_NSAlertButton: 0x15910bbb0> as the first responder for window <_NSAlertPanel: 0x159113660> windowNumber=a041, but it is in a different window ((null))! This would eventually crash when the view is freed. The first responder will be set to nil.
        let str = NSPasteboard.general.string(forType: .string)
        
        if let str {
            logger.notice("Got string from pasteboard: \"\(str)\"")
        } else {
            logger.notice("No string on pasteboard")
        }
    }
}
