//
//  AppDelegate.swift
//  Test2
//
//  Created by Hoon H. on 2015/01/12.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Cocoa
import PseudoTeletypewriter

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!


	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		let	pty	=	PseudoTeletypewriter(path: "/bin/ls", arguments: ["/bin/ls", "-Gbla"], environment: ["TERM=ansi"])!
		print(pty.masterFileHandle.readDataToEndOfFile().toString())
		pty.waitUntilChildProcessFinishes()
		
		
//		let	pty	=	PseudoTeletypewriter(path: "/bin/bash", arguments: ["/bin/bash"], environment: ["TERM=ansi"])!
////		pty.masterFileHandle.writeData("ls -Gbla\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
////		println(pty.masterFileHandle.availableData.toString())
//		
//		sleep(1)
//		println(pty.masterFileHandle.availableData.toString())
//		pty.masterFileHandle.writeData("sudo /bin/ls\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)		///	`sudo` also works.
//		
//		sleep(2)
//		println(pty.masterFileHandle.availableData.toString())
//		pty.masterFileHandle.writeData("<type your root password here to test pty>\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
//		
//		sleep(1)
//		println(pty.masterFileHandle.availableData.toString())
//		pty.masterFileHandle.writeData("exit\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!)
//		
//		println(pty.masterFileHandle.readDataToEndOfFile().toString())
//		pty.waitUntilChildProcessFinishes()
		
		NSApplication.shared().terminate(self)
		
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}









extension Data {
    
	func toUInt8Array() -> [UInt8] {
        let	p	=	(self as NSData).bytes
        
        var	bs	=	[] as [UInt8]
        for i in 0..<self.count {
            let dataPtr = p.advanced(by: i)
            let datum = dataPtr.load(as: UInt8.self)
            bs.append(datum)
        }
        
        return	bs
	}
	func toString() -> String {
		return	NSString(data: self, encoding: String.Encoding.utf8.rawValue)! as String
	}
	static func fromUInt8Array(_ bs:[UInt8]) -> Data {
		var	r	=	nil as Data?
		bs.withUnsafeBufferPointer { (p:UnsafeBufferPointer<UInt8>) -> () in
			let	p1	=	UnsafeRawPointer(p.baseAddress)!
            let opPtr = OpaquePointer(p1)
			r		=	Data(bytes: UnsafePointer<UInt8>(opPtr), count: p.count)
		}
		return	r!
	}
	
	///	Assumes `cCharacters` is C-string.
	static func fromCCharArray(_ cCharacters:[CChar]) -> Data {
		precondition(cCharacters.count == 0 || cCharacters[(cCharacters.endIndex - 1)] == 0)
		var	r	=	nil as Data?
		cCharacters.withUnsafeBufferPointer { (p:UnsafeBufferPointer<CChar>) -> () in
			let	p1	=	UnsafeRawPointer(p.baseAddress)!
            let opPtr = OpaquePointer(p1)
			r		=	Data(bytes: UnsafePointer<UInt8>(opPtr), count: p.count)
		}
		return	r!
	}
}
