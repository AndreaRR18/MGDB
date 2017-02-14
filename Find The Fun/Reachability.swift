import Foundation
import SystemConfiguration

let ReachabilityDidChangeNotificationName = "ReachabilityDidChangeNotification"

enum ReachabilityStatus {
    case notReachable
    case reachableViaWiFi
    case reachableViaWAN
}


class Reachability: NSObject {
    private var networkingReachability: SCNetworkReachability?
    
    init?(hostName: String) {
        networkingReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, (hostName as NSString).utf8String!)
        super.init()
        if networkingReachability == nil {
            return nil
        }
    }
    
    init?(hostAddress: sockaddr_in) {
        var address = hostAddress
        
        guard let defalutRouteReachability = withUnsafePointer(to: &address, { $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, $0) } }) else { return nil }
        networkingReachability = defalutRouteReachability
        
        super.init()
        if networkingReachability == nil {
            return nil
        }
    }
    
    static func networkReachabilityForInternetConnection() -> Reachability? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        return Reachability(hostAddress: zeroAddress)
    }
    
    static func networkReachabilityForLocalWiFi() -> Reachability? {
        var localWifiAddress = sockaddr_in()
        localWifiAddress.sin_len = UInt8(MemoryLayout.size(ofValue: localWifiAddress))
        localWifiAddress.sin_family = sa_family_t(AF_INET)
        localWifiAddress.sin_addr.s_addr = 0xA9FE000
        return Reachability(hostAddress: localWifiAddress)
    }
    
    
    private var notifying: Bool = false
    
    func startNotifier() -> Bool {
        guard notifying == false else { return false }
        var context = SCNetworkReachabilityContext()
        context.info = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        guard let reachability = networkingReachability, SCNetworkReachabilitySetCallback(
            reachability,
            { (target: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
                if let currentInfo = info {
                    let infoObject = Unmanaged<AnyObject>.fromOpaque(currentInfo).takeUnretainedValue()
                    if infoObject is Reachability {
                        let networkReachability = infoObject as! Reachability
                        NotificationCenter.default.post(name: Notification.Name(rawValue: ReachabilityDidChangeNotificationName), object: networkReachability)
                    }
                }
        }, &context) == true else { return false }
        guard SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue) == true else { return false }
        notifying = true
        return notifying
    }
    
    func stopNotifier() {
        if let reachability = networkingReachability, notifying == true {
            SCNetworkReachabilityUnscheduleFromRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode as! CFString)
            notifying = false
        }
    }
    
    deinit {
        stopNotifier()
    }
    
    
    private var flags: SCNetworkReachabilityFlags {
        var flags = SCNetworkReachabilityFlags(rawValue: 0)
        if let reachability = networkingReachability, withUnsafeMutablePointer(to: &flags, { SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0)) }) == true {
            return flags
        }
        else {
            return []
        }
    }

    var currentReachabilityStatus: ReachabilityStatus {
        if flags.contains(.reachable) == false {
            return .notReachable
        } else if flags.contains(.isWWAN) == true {
            return .reachableViaWiFi
        } else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            return .reachableViaWiFi
        } else {
            return .notReachable
        }
    }

    var isReachable: Bool {
        switch currentReachabilityStatus {
        case .notReachable:
            return false
        case .reachableViaWiFi, .reachableViaWAN:
            return true
        }
    }
}
